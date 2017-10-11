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

//class CameraViewController: EPLBaseViewController, EPLCameraHelperDelegate {
    
//    @IBOutlet weak var previewView: UIImageView!
//    @IBOutlet weak var cameraView: UIView!
//    @IBOutlet weak var flashButton: UIButton!
//    @IBOutlet weak var photoButton: EPLButton!
//    @IBOutlet weak var videoButton: EPLButton!
//    @IBOutlet weak var shutterButton: UIButton!
//
//    var cameraHelper:EPLCameraHelper!
//    var flashImages:[UIImage]!
//    var selectedFlashImageIndex = 0
//    var cameraMode = EPLCameraHelper.CameraMode.Photo
//    var isRecording = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.cameraHelper = EPLCameraHelper(cameraDelegate: self, previewView: cameraView)
//        loadFlashImages()
//        setCameraMode(cameraMode: EPLCameraHelper.CameraMode.Photo)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    func loadFlashImages() {
//        self.flashImages = [UIImage(named: "flash_auto")!, UIImage(named: "flash_enabled")!, UIImage(named: "flash_disabled")!]
//        flashButton.setImage(self.flashImages[0], for: UIControlState.normal)
//    }
//
//    func changeFlashButtonImage() {
//        selectedFlashImageIndex += 1
//        if selectedFlashImageIndex == self.flashImages.count {
//           selectedFlashImageIndex = 0
//        }
//
//        self.flashButton.setImage(self.flashImages[selectedFlashImageIndex], for: UIControlState.normal)
//    }
//
//    func setCameraMode(cameraMode:EPLCameraHelper.CameraMode) {
//        if cameraMode == .Photo {
//            photoButton.setTitleColor(UIColor.yellow, for: UIControlState.normal)
//            videoButton.setTitleColor(UIColor.white, for: UIControlState.normal)
//            shutterButton.setBackgroundImage(UIImage(named: "takePic"), for: UIControlState.normal)
//        } else {
//            photoButton.setTitleColor(UIColor.white, for: UIControlState.normal)
//            videoButton.setTitleColor(UIColor.yellow, for: UIControlState.normal)
//            shutterButton.setBackgroundImage(UIImage(named: "rec"), for: UIControlState.normal)
//        }
//    }
//
//    //MARK: - @IBAction
//    @IBAction func cameraAction(_ sender: Any) {
//        if self.cameraMode == .Photo {
//            cameraHelper.takePicture()
//        } else {
//            if isRecording {
//                isRecording = false
//                cameraHelper.stopRecordingVideo()
//            } else {
//                isRecording = true
//                //cameraHelper.startRecordingVideo(fileUrl: <#T##URL#>)
//            }
//        }
//    }
//
//    @IBAction func menuAction(_ sender: UIButton) {
//        toggleDrawer()
//    }
//
//    @IBAction func toggleCameraAction(_ sender: Any) {
//        cameraHelper.toggleCamera()
//    }
//
//    @IBAction func flashButtonAction(_ sender: UIButton) {
//        changeFlashButtonImage()
//    }
//
//    @IBAction func chooseEditionAction(_ sender: UIButton) {
//    }
//
//    @IBAction func chooseEventAction(_ sender: UIButton) {
//    }
//
//    @IBAction func photoButtonAction(_ sender: Any) {
//        self.cameraMode = EPLCameraHelper.CameraMode.Photo
//        setCameraMode(cameraMode: self.cameraMode)
//    }
//
//    @IBAction func videoButtonAction(_ sender: Any) {
//        self.cameraMode = EPLCameraHelper.CameraMode.Video
//        setCameraMode(cameraMode: self.cameraMode)
//    }
//
//    //MARK: - EPLCameraHelperDelegate
//    func onPictureImageCreated(image: UIImage?, error: Error?) {
//
//    }
//
//    func onScaledPictureImageCreated(image: UIImage?, error: Error?) {
//        if let img = image {
//            self.previewView.image = img
//        }
//    }
//
//    func onPictureSampleBufferCreated(picSampleBuffer: CMSampleBuffer?) {
//
//    }
    
//}
