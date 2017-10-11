//
//  MediaViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 23/09/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import DownPicker

class MediaViewController: EPLBaseViewController {
    
    @IBOutlet weak var edition: UITextField!
    @IBOutlet weak var event: UITextField!
    @IBOutlet weak var mediaContainer: UIView!
    @IBOutlet weak var captureMediaButton: UIButton!
    @IBOutlet weak var mediaLibraryButton: UIButton!
    
    var imagePicker:UIImagePickerController!
    var editionDowPicker:DownPicker!
    var editionVal = 0
    var envetVal = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("MEDIA", comment: "")
        self.captureMediaButton.isEnabled = false
        self.setupImagePicker()
        self.setupDownPicker(textField: self.edition
            , placeHolder: "CHOOSE_EDITION"
            , list: getListOfEditions()
            , target: #selector(dpEditionSelected))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    func setupImagePicker() {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.imagePicker.showsCameraControls = true
        if let mediaTypes = UIImagePickerController.availableMediaTypes(for: self.imagePicker.sourceType) {
            self.imagePicker.mediaTypes = mediaTypes
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func getListOfEditions() -> Array<String> {
        var arr = Array<String>()
        for i in 1...5 {
            arr.append("Edição \(i)")
        }
        
        return arr
    }
    
    func setupDownPicker(textField:UITextField, placeHolder:String, list:Array<String>, target:Selector) {
        let downPicker = DownPicker.init(textField: textField, withData: list)
        downPicker?.setPlaceholder(NSLocalizedString(placeHolder, comment: ""))
        downPicker?.setToolbarDoneButtonText(NSLocalizedString("OK", comment: ""))
        downPicker?.setToolbarCancelButtonText(NSLocalizedString("CANCEL", comment: ""))
        downPicker?.addTarget(self, action: target, for: .valueChanged)
    }

    func dpEditionSelected() {
        self.editionVal = 3
    }
    
    func dpEventSelected() {
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
}
