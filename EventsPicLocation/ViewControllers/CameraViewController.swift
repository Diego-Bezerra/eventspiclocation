//
//  CameraViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 16/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

class CameraViewController: UIViewController, EPLCameraHelperDelegate {
    
    @IBOutlet weak var previewView: UIImageView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var photoButton: EPLButton!
    @IBOutlet weak var videoButton: EPLButton!
    
    var cameraHelper:EPLCameraHelper!
    var flashImages:[UIImage]!
    var selectedFlashImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.cameraHelper = EPLCameraHelper(cameraDelegate: self, previewView: cameraView)
        loadFlashImages()
        setCameraMode(cameraMode: EPLCameraHelper.CameraMode.Photo)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func takePicAction(_ sender: Any) {
         cameraHelper.takePicture()
    }
    
    func loadFlashImages() {
        self.flashImages = [UIImage(named: "flash_auto")!, UIImage(named: "flash_enabled")!, UIImage(named: "flash_disabled")!]
        flashButton.setImage(self.flashImages[0], for: UIControlState.normal)
    }
    
    func changeFlashButtonImage() {
        selectedFlashImageIndex += 1
        if selectedFlashImageIndex == self.flashImages.count {
           selectedFlashImageIndex = 0
        }
        
        self.flashButton.setImage(self.flashImages[selectedFlashImageIndex], for: UIControlState.normal)
    }
    
    func setCameraMode(cameraMode:EPLCameraHelper.CameraMode) {
        if cameraMode == .Photo {
            photoButton.setTitleColor(UIColor.yellow, for: UIControlState.normal)
            videoButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        } else {
            photoButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            videoButton.setTitleColor(UIColor.yellow, for: UIControlState.normal)
        }
    }
    
    //MARK: - @IBAction
    @IBAction func flashButtonAction(_ sender: UIButton) {
        changeFlashButtonImage()
    }
    
    @IBAction func chooseEditionAction(_ sender: UIButton) {
    }
    
    @IBAction func chooseEventAction(_ sender: UIButton) {
    }
    
    @IBAction func photoButtonAction(_ sender: Any) {
        setCameraMode(cameraMode: EPLCameraHelper.CameraMode.Photo)
    }
    
    @IBAction func videoButtonAction(_ sender: Any) {
        setCameraMode(cameraMode: EPLCameraHelper.CameraMode.Video)
    }
    
    //MARK: - EPLCameraHelperDelegate
    func onPictureImageCreated(image: UIImage?, error: Error?) {
        
    }
    
    func onScaledPictureImageCreated(image: UIImage?, error: Error?) {
        if let img = image {
            self.previewView.image = img
        }
    }
    
    func onPictureSampleBufferCreated(picSampleBuffer: CMSampleBuffer?) {
        
    }
    
}
