//
//  EPLCameraUtils.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 18/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import AVFoundation

protocol EPLCameraHelperDelegate: class {
    func onPictureImageCreated(image:UIImage?, error:Error?)
    func onScaledPictureImageCreated(image:UIImage?, error:Error?)
    func onPictureSampleBufferCreated(picSampleBuffer: CMSampleBuffer?)
}

class EPLCameraHelper: NSObject, AVCapturePhotoCaptureDelegate, AVCaptureFileOutputRecordingDelegate {
    
    var session: AVCaptureSession!
    var cameraPhotoOutput: Any?
    var cameraMovieOutput: AVCaptureMovieFileOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var previewView:UIView?    
    weak var cameraDelegate:EPLCameraHelperDelegate?

    enum CameraMode {
        case Photo, Video
    }
    
    convenience init(cameraDelegate:EPLCameraHelperDelegate, previewView:UIView) {
        self.init()
        self.cameraDelegate = cameraDelegate
        self.previewView = previewView
        setupCamera()
    }
    
    private func setupCamera() {
        
        session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetMedium
        
        do {
            try createInput(devicePosition: AVCaptureDevicePosition.back)
            try createOutput(outputType: OutputType.Photo)
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    func getCameraDeviceByPosition(devicePosition:AVCaptureDevicePosition) -> AVCaptureDevice? {
        for device:AVCaptureDevice in AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! Array<AVCaptureDevice> {
            if device.position == devicePosition {
                return device
            }
        }
        
        return nil
    }
    
    func toggleCamera() {
        if self.session.inputs.count > 0 {
            self.session.beginConfiguration()
            let input = session.inputs[0] as! AVCaptureDeviceInput
            let newDevicePosition = input.device.position == AVCaptureDevicePosition.back ? AVCaptureDevicePosition.front : AVCaptureDevicePosition.back
            do {
                try createInput(devicePosition: newDevicePosition)
            } catch {
                print(error.localizedDescription)
            }
            self.session.commitConfiguration()
        }
    }
    
    private func createInput(devicePosition:AVCaptureDevicePosition) throws {
        do {
            guard let camera = getCameraDeviceByPosition(devicePosition:devicePosition) else {
                throw EPLCameraHelperError.noCamera
            }
            try createInput(forDevice: camera, withSession: self.session)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func createInput(forDevice device:AVCaptureDevice, withSession session:AVCaptureSession) throws {
        do {
            
            if self.session.inputs.count > 0 {
                session.removeInput(self.session.inputs[0] as! AVCaptureInput)
            }
            
            let cameraInput = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(cameraInput) {
                session.addInput(cameraInput)
            } else {
                throw EPLCameraHelperError.noInput
            }
        } catch {
            throw error
        }
    }
    
    enum OutputType:Int {
        case Photo, Video
    }
    
    func createOutput(outputType:OutputType) throws {
        
        if self.session.outputs.count > 0 {
            self.session.removeOutput(self.session.outputs[0] as! AVCaptureOutput)
        }
        
        switch outputType {
        case .Photo:
            do {
                try createPhotoOutput(withSession: self.session)
            } catch {
                throw EPLCameraHelperError.noOutput
            }
            break
        case .Video:
            do {
                try createVideoOutput()
            } catch {
                throw EPLCameraHelperError.noOutput
            }
            break
        }
    }
    
    private func createVideoOutput() throws {
        self.cameraMovieOutput = AVCaptureMovieFileOutput()
        if self.session.canAddOutput(self.cameraMovieOutput) {
            self.session.addOutput(self.cameraMovieOutput)
        }  else {
            throw EPLCameraHelperError.noOutput
        }
    }
    
    private func createPhotoOutput(withSession session:AVCaptureSession) throws {
        do {
            if #available(iOS 10, *) {
                try createOutputLatestVersion(withSession: session)
            } else {
                try createOutputPreviousVersion(withSession: session)
            }
        } catch {
            throw error
        }
    }
    
    private func createOutputPreviousVersion(withSession session:AVCaptureSession) throws {
        self.cameraPhotoOutput = AVCaptureStillImageOutput()
        if let camOut = self.cameraPhotoOutput as? AVCaptureStillImageOutput {
            camOut.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            
            if session.canAddOutput(camOut) {
                session.addOutput(camOut)
                createVideoPreviewLayer()
            } else {
                throw EPLCameraHelperError.noOutput
            }
        }
    }
    
    @available(iOS 10, *)
    private func createOutputLatestVersion(withSession session:AVCaptureSession) throws {
        
        self.cameraPhotoOutput = AVCapturePhotoOutput()
        if let camOut = self.cameraPhotoOutput as? AVCapturePhotoOutput {
            if session.canAddOutput(camOut) {
                session.addOutput(camOut)
                createVideoPreviewLayer()
            } else {
                throw EPLCameraHelperError.noOutput
            }
        }
    }
    
    func takePicture() {
        if let camOut = self.cameraPhotoOutput {
            if #available(iOS 10, *) {
                capturePhotoLatestVersion(output: camOut as! AVCapturePhotoOutput)
            } else {
                capturePhotoPreviousVersion(output: camOut as! AVCaptureStillImageOutput)
            }
        }
    }
    
    func startRecordingVideo(fileUrl:URL) {
        if self.cameraMovieOutput != nil {
            self.cameraMovieOutput?.startRecording(toOutputFileURL: fileUrl, recordingDelegate: self)
        }
    }
    
    func stopRecordingVideo() {
        if self.cameraMovieOutput != nil {
            self.cameraMovieOutput?.stopRecording()
        }
    }
    
    @available(iOS 10, *)
    private func capturePhotoLatestVersion(output:AVCapturePhotoOutput) {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 60,
                             kCVPixelBufferHeightKey as String: 60]
        settings.previewPhotoFormat = previewFormat
        output.capturePhoto(with: settings, delegate: self)
    }
    
    private func capturePhotoPreviousVersion(output:AVCaptureStillImageOutput) {
        if let videoConnection = output.connection(withMediaType: AVMediaTypeVideo) {
            output.captureStillImageAsynchronously(from: videoConnection, completionHandler: { [weak self] (sampleBuffer, error) in
                if let weakSelf = self {
                    weakSelf.handleCallback(sampleBuffer: sampleBuffer)
                }
            })
        }
    }
    
    private func createVideoPreviewLayer() {
        do {
            if let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session) {
                self.videoPreviewLayer = videoPreviewLayer
                videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                if let bounds = previewView?.bounds {
                    setVideoCameraFrame(frame: bounds)
                }
                videoPreviewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                previewView?.layer.addSublayer(videoPreviewLayer)
                session.startRunning()
            } else {
                throw EPLCameraHelperError.noVideoPreviewLayer
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setVideoCameraFrame(frame:CGRect) {
        self.videoPreviewLayer?.frame = frame
    }        
    
    //MARK: - AVCapturePhotoCaptureDelegate
    @available(iOS 10.0, *)
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        handleCallback(sampleBuffer: photoSampleBuffer)
    }
    
    private enum EPLCameraHelperError: Error, LocalizedError {
        case noSampleBuffer
        case noImageData
        case noDataProvider
        case noCGImage
        case noVideoPreviewLayer
        case noInput
        case noOutput
        case noCamera
        
        public var errorDescription: String? {
            switch self {
            case .noSampleBuffer:
                return "sampleBuffer is nil"
            case .noImageData:
                return "imageData is nil"
            case .noDataProvider:
                return "dataProvider is nil"
            case .noCGImage:
                return "cgImage is nil"
            case .noVideoPreviewLayer:
                return "videoPreviewLayer is nil"
            case .noInput:
                return "input cannot be created"
            case .noOutput:
                return "output cannot be created"
            case .noCamera:
                return "no camera camera available"
            }
        }
    }
    
    private func handleCallback(sampleBuffer buffer:CMSampleBuffer?) {
        do {
            let images = try handle(sampleBuffer: buffer)
            callbackDelegate(image: images.image, scaledImage: images.scaledImage, sampleBuffer: buffer, error: nil)
        } catch  {
            print(error.localizedDescription)
            callbackDelegate(sampleBuffer: buffer, error: error)
        }
    }
    
    private func callbackDelegate(sampleBuffer:CMSampleBuffer?, error:Error?) {
        callbackDelegate(image: nil, scaledImage: nil, sampleBuffer: sampleBuffer, error: error)
    }
    
    private func callbackDelegate(image:UIImage?, scaledImage:UIImage?, sampleBuffer:CMSampleBuffer?, error:Error?) {
        cameraDelegate?.onScaledPictureImageCreated(image: scaledImage, error: error)
        cameraDelegate?.onPictureImageCreated(image: image, error: error)
        cameraDelegate?.onPictureSampleBufferCreated(picSampleBuffer: sampleBuffer)
    }
    
    private func handle(sampleBuffer buffer:CMSampleBuffer?) throws -> (scaledImage:UIImage, image:UIImage) {
        
        guard let sb = buffer else {
            throw EPLCameraHelperError.noSampleBuffer
        }
        guard let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sb) else {
            throw EPLCameraHelperError.noImageData
        }
        guard let dataProvider = CGDataProvider.init(data: imageData as CFData) else {
            throw EPLCameraHelperError.noDataProvider
        }
        guard let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent) else {
            throw EPLCameraHelperError.noCGImage
        }
        
        let scaledImage = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.right)
        let image = UIImage(cgImage: cgImageRef)
        return (scaledImage, image)
    }
    
    //MARK: - AVCaptureFileOutputRecordingDelegate
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        
    }
}
