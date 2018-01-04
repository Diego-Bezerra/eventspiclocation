//
//  MediaViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 23/09/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit

class MediaViewController: EPLBaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate {
    
    @IBOutlet weak var lotteryTextView: EPLTextField!
    @IBOutlet weak var subjectTextView: UITextField!
    @IBOutlet weak var galleryContainer: UIView!
    
    var imagePicker:UIImagePickerController!
    var lotteryDowPicker:DownPicker!
    var subjectDowPicker:DownPicker!
    var editionVal = 0
    var envetVal = 0
    var lotterySubjectListsVO:LotterySubjectListsVO?
    var galleryViewController: GalleryViewController!

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
        if lotteryDowPicker.selectedIndex > 0 && subjectDowPicker.selectedIndex > 0 {
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
        downPicker?.addTarget(self, action: target, for: .valueChanged)
        
        return downPicker
    }

    func dpLotterySelected() {
        self.editionVal = 3
    }
    
    func dpSubjectSelected() {
        //self.even = 3
    }
    
    @IBAction func captureMediasAction(_ sender: Any) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openPhotosVideosLibraryAction(_ sender: Any) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func saveImageFile(image:UIImage) {
        let path = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        let newPath = path.appendingPathComponent("image.jpg")
        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
        do {
            try jpgImageData!.write(to: newPath)
            galleryViewController.addImageToGallery(path: newPath.absoluteString)
        } catch {
            print(error)
        }
    }
    
    func saveVideoFile(videoURL: NSURL) {
        let videoData = NSData(contentsOf: videoURL as URL)
        let path = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        let newPath = path.appendingPathComponent("/videoFileName.mp4")
        do {
            try videoData?.write(to: newPath)
        } catch {
            print(error)
        }
    }
    
    func createNewMedia() {
        
//        @NSManaged public var date: NSDate?
//        @NSManaged public var id: Int64
//        @NSManaged public var lat: Double
//        @NSManaged public var lng: Double
//        @NSManaged public var file: String?
//        @NSManaged public var subject: Subject?
//        @NSManaged public var lottery: Lottery?
//        @NSManaged public var user: User?
        
        let newMedia:Media = Media.create() as! Media
        newMedia.date = NSDate()
        //newMedia.lat =
    }
    
    //MARK - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            saveImageFile(image: image)
            
        } else if let videoURL = info[UIImagePickerControllerMediaURL] as? NSURL {
            saveVideoFile(videoURL: videoURL)
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
            print("Add from gallery")
        case 2:
            print("Take picture")
            self.present(imagePicker, animated: true, completion: nil)
        default:
            print("Nothing")
        }
    }
}
