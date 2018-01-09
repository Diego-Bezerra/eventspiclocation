//
//  MediaViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 23/09/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import CoreLocation

class MediaViewController: EPLBaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate {
    
    @IBOutlet weak var lotteryTextView: EPLTextField!
    @IBOutlet weak var subjectTextView: UITextField!
    @IBOutlet weak var galleryContainer: UIView!
    
    var imagePicker:UIImagePickerController!
    var lotteryDowPicker:DownPicker!
    var subjectDowPicker:DownPicker!
    var lotterySubjectListsVO:LotterySubjectListsVO?
    var selectedLottery:LotteryVO?
    var selectedSubject:SubjectVO?
    var galleryViewController: GalleryViewController!
    
    let photoPrefix = "photo"
    let videoPrefix = "video"        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = EPLHelper.localized(string: "MEDIA")
        self.setupImagePicker()
        self.setupNavigationButton()
        self.setupGalleryContainer()
        self.getLotteryAndSubjectList()
        self.lotteryTextView.isEnabled = false
        self.subjectTextView.isEnabled = false
    }

    func setupGalleryContainer() {
        self.galleryViewController = GalleryViewController()
        galleryViewController.view.frame = CGRect(x: 0
            , y: 0
            , width: galleryContainer.frame.size.width
            , height: galleryContainer.frame.size.height)
        self.addChildViewController(galleryViewController)
        galleryContainer.addSubview(galleryViewController.view)
        galleryViewController.didMove(toParentViewController: self)
    }
    
    func setupNavigationButton() {
        let rightButon = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add
            , target: self
            , action: #selector(addAction))
        self.navigationItem.rightBarButtonItem = rightButon
    }
    
    func addAction() {
        if selectedLottery != nil && selectedSubject != nil {
            UIActionSheet(title: EPLHelper.localized(string: "ADD_NEW_IMAGE")
                , delegate: self
                , cancelButtonTitle: EPLHelper.localized(string: "CANCEL")
                , destructiveButtonTitle: nil
                , otherButtonTitles: EPLHelper.localized(string: "ADD_FROM_GALLERY"), EPLHelper.localized(string: "TAKE_PICTURE"))
                .show(in: self.view)
        } else {
            EPLHelper.showHud(withView: self.view, andLocalizedMessage: "CHOSSE_VALUES")
        }
    }
    
    func getLotteryAndSubjectList() {
        EPLHelper.showProgress(withView: self.view)
        ApiService.getLotteryAndSubjectList { [weak self] (lotterySubjectListsVO) in
            
            guard let s = self else {
                return
            }
            
            guard let lotVo = lotterySubjectListsVO
                , let loList = lotVo.lotteries
                , let subList = lotVo.subjects else {
                    
                EPLHelper.hideProgress(withView: s.view)
                EPLHelper.showHud(withView: s.view, andLocalizedMessage: "GENERIC_PROBLEM")
                    
                return
            }
            
            s.lotterySubjectListsVO = lotterySubjectListsVO
            
            s.lotteryTextView.isEnabled = true
            s.subjectTextView.isEnabled = true
            
            let lotteryList = s.getLotteryStringList(list: loList)
            s.lotteryDowPicker = s.setupDownPicker(
                textField: s.lotteryTextView
                , placeHolder: EPLHelper.localized(string: "CHOOSE_EDITION")
                , list: lotteryList
                , target: #selector(s.dpLotterySelected))
            
            let subjectsList = s.getsubjectsStringList(list: subList)
            s.subjectDowPicker = s.setupDownPicker(
                textField: s.subjectTextView
                , placeHolder: EPLHelper.localized(string: "CHOOSE_EVENT")
                , list: subjectsList
                , target: #selector(s.dpSubjectSelected))
            
            EPLHelper.hideProgress(withView: s.view)
        }
    }
    
    func getLotteryStringList(list:[LotteryVO]) -> [String] {
        var listStr = [String]()
        for lo:LotteryVO in list {
            listStr.append(lo.mDescription!)
        }
        
        return listStr
    }
    
    func getsubjectsStringList(list:[SubjectVO]) -> [String] {
        var listStr = [String]()
        for su:SubjectVO in list {
            listStr.append(su.mDescription!)
        }
        
        return listStr
    }
    
    func setupImagePicker() {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.imagePicker.showsCameraControls = true
        self.imagePicker.delegate = self
        if let mediaTypes = UIImagePickerController.availableMediaTypes(for: self.imagePicker.sourceType) {
            self.imagePicker.mediaTypes = mediaTypes
        }
    }
    
    func setupDownPicker(textField:UITextField, placeHolder:String, list:Array<String>, target:Selector) -> DownPicker! {
        let downPicker = DownPicker.init(textField: textField, withData: list)
        downPicker?.setFixedArrowImage(UIImage(named: "expand"))
        downPicker?.setPlaceholder(NSLocalizedString(placeHolder, comment: ""))
        downPicker?.setToolbarDoneButtonText(NSLocalizedString("OK", comment: ""))
        downPicker?.setToolbarCancelButtonText(NSLocalizedString("CANCEL", comment: ""))
        downPicker?.addTarget(self, action: target, for: .editingDidEnd)
        
        
        return downPicker
    }

    func dpLotterySelected() {
        self.selectedLottery = lotterySubjectListsVO?.lotteries?[lotteryDowPicker.selectedIndex]
        reloadGallery()
    }
    
    func dpSubjectSelected() {
        self.selectedSubject = lotterySubjectListsVO?.subjects?[subjectDowPicker.selectedIndex]
        reloadGallery()
    }
    
    func reloadGallery() {
        let lotId = selectedLottery?.id
        let subId = selectedSubject?.id
        galleryViewController.setLotteryId(lotId: lotId, andSubjectId: subId)
    }
    
    @IBAction func captureMediasAction(_ sender: Any) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openPhotosVideosLibraryAction(_ sender: Any) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func saveImageFile(image:UIImage, fileName:String) {
        
        let newPath = EPLHelper.getFileURL(fileName: fileName)
        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
        do {
            try jpgImageData!.write(to: newPath)
        } catch {
            print(error)
        }
    }
    
    func saveVideoFile(videoURL: NSURL, fileName:String) {
        
        let videoData = NSData(contentsOf: videoURL as URL)
        let newPath = EPLHelper.getFileURL(fileName: fileName)
        do {
            try videoData!.write(to: newPath)
        } catch {
            print(error)
        }
    }
    
    func createNewMedia(fileName:String, fileMimeType:FileMediaInfo.FileMimeType, completion: @escaping (Bool) -> Void)  {
        
        EPLHelper.showProgress(withView: self.view)
        
        let location:CLLocation? = EPLLocationHelper.sharedInstance.getCurrentLocation()
        guard let lat = location?.coordinate.latitude, let lng = location?.coordinate.longitude else {
            EPLHelper.showHud(withView: self.view, andLocalizedMessage: "LOCATION_ERROR")
            EPLHelper.hideProgress(withView: self.view)
            completion(false)
            return;
        }
        guard let sub = selectedSubject, let lot = selectedLottery else {
            EPLHelper.showHud(withView: self.view, andLocalizedMessage: "CHOSSE_VALUES")
            EPLHelper.hideProgress(withView: self.view)
            completion(false)
            return
        }

        if let newMedia = MediaRequestVO(JSON: [String : Any]()) {
            newMedia.login = EPLUserPreferencesHelper.getUserAuth()
            newMedia.dataHora = Date()
            newMedia.latitude = lat
            newMedia.longitude = lng
            newMedia.mimeType = FileMediaInfo.getMimeTypeStr(fileMimeType: fileMimeType)
            newMedia.idAssunto = lot.id
            newMedia.idSorteio = sub.id
            
            ApiService.saveMedia(media: newMedia, fileName: fileName, completion: { [unowned self] (isSuccess) in
                if !isSuccess {
                    EPLHelper.showHud(withView: self.view, andLocalizedMessage: "SAVE_MEDIA_PROBLEM")
                    completion(false)
                } else {
                    completion(true)
                    self.galleryViewController.reload()
                }
                EPLHelper.hideProgress(withView: self.view)
            })
        } else {
            EPLHelper.showHud(withView: self.view, andLocalizedMessage: "SAVE_MEDIA_PROBLEM")
            EPLHelper.hideProgress(withView: self.view)
            completion(false)
        }
    }        
    
    //MARK - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let fileName = EPLHelper.uniqueFilename(prefix: photoPrefix)
            createNewMedia(fileName: fileName, fileMimeType: FileMediaInfo.FileMimeType.Imagem, completion: { [unowned self] (isSuccess) in
                if isSuccess {
                    self.saveImageFile(image: image, fileName: fileName)
                    self.galleryViewController.reload()
                }
            })
        } else if let videoURL = info[UIImagePickerControllerMediaURL] as? NSURL {
            let fileName = EPLHelper.uniqueFilename(prefix: videoPrefix)
            createNewMedia(fileName: fileName, fileMimeType: FileMediaInfo.FileMimeType.Video, completion: { [unowned self] (isSuccess) in
                if isSuccess {
                    self.saveVideoFile(videoURL: videoURL, fileName: fileName)
                    self.galleryViewController.reload()
                }
            })
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK - UIActionSheetDelegate
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        switch (buttonIndex) {
        case 1:
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        case 2:
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        default:
            print("Nothing")
        }
    }
}
