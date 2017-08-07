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
    
    var cameraHelper:EPLCameraHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.cameraHelper = EPLCameraHelper(cameraDelegate: self, previewView: cameraView)
        
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
