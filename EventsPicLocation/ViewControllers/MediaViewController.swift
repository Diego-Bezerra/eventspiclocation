//
//  MediaViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 23/09/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import DownPicker

class MediaViewController: EPLBaseViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var lotteryTextView: EPLTextField!
    @IBOutlet weak var subjectTextView: UITextField!
    @IBOutlet weak var captureMediaButton: UIButton!
    @IBOutlet weak var mediaLibraryButton: UIButton!
    
    var imagePicker:UIImagePickerController!
    var lotteryDowPicker:DownPicker!
    var subjectDowPicker:DownPicker!
    var editionVal = 0
    var envetVal = 0
    var lotterySubjectListsVO:LotterySubjectListsVO?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("MEDIA", comment: "")
        self.captureMediaButton.isEnabled = false
        //self.setupImagePicker()
        self.getLotteryAndSubjectList()
        self.toggleButtons(enable: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
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
                    
                EPLHelper.showHud(withView: s.view, andLocalizedMessage: "GENERIC_PROBLEM")
                EPLHelper.hideProgress(withView: s.view)
                s.toggleButtons(enable: false)
                return
            }
            
            let lotteryList = s.getLotteryStringList(list: loList)
            s.lotteryDowPicker = s.setupDownPicker(
                textField: s.lotteryTextView
                , placeHolder: EPLHelper.localized(string: "CHOOSE_EDITION")
                , list: lotteryList
                , target: #selector(s.dpLotterySelected))
            
            let subjectsList = s.getsubjectsStringList(list: subList)
            s.subjectDowPicker = s.setupDownPicker(
                textField: s.subjectTextView
                , placeHolder: EPLHelper.localized(string: "CHOOSE_EDITION")
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
    
    func toggleButtons(enable:Bool) {
        captureMediaButton.isEnabled = enable
        mediaLibraryButton.isEnabled = enable
    }
    
    func setupImagePicker() {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.imagePicker.showsCameraControls = true
        //self.imagePicker.delegate = self
        if let mediaTypes = UIImagePickerController.availableMediaTypes(for: self.imagePicker.sourceType) {
            self.imagePicker.mediaTypes = mediaTypes
            //self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func setupDownPicker(textField:UITextField, placeHolder:String, list:Array<String>, target:Selector) -> DownPicker! {
        let downPicker = DownPicker.init(textField: textField, withData: list)
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
    
    //MARK - UIImagePickerControllerDelegate
    
}
