//
//  Helper.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 16/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import MBProgressHUD
import SDWebImage
import AVFoundation
import ReachabilitySwift

class EPLHelper {
    
    static func localized(string:String) -> String {
        return NSLocalizedString(string, comment: "")
    }
    
    static func showHud(withView view:UIView, localizedMessage:String, andOffSetPoint point:CGPoint) {
        showHud(withView: view, message: EPLHelper.localized(string: localizedMessage), andOffSetPoint: point)
    }
    
    static func showHud(withView view:UIView, andLocalizedMessage localizedMessage:String) {
        showHud(withView: view, message: EPLHelper.localized(string: localizedMessage), andOffSetPoint: nil)
    }
    
    static func showHud(withView view:UIView, message:String, andOffSetPoint point:CGPoint?) {
        
        DispatchQueue.main.async {
        
            let hudDelay = TimeInterval(3)
            
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.isUserInteractionEnabled = false
            hud.label.text = message
            if let newOffset = point {
                hud.offset = newOffset
            }
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: hudDelay)
        }
    }
    
    static var progress:MBProgressHUD?
    
    static func showProgress(withView view:UIView) {
        if progress != nil {
            progress?.hide(animated: true)
        }
        progress = MBProgressHUD.showAdded(to:view , animated: true)
    }
    
    static func hideProgress(withView view:UIView) {
        progress?.hide(animated: true)
    }
    
    static func showAlert(message:String, viewController:UIViewController, completion: @escaping (UIAlertAction) -> Void) {
        showAlert(title: "", message: message, viewController: viewController, completion: completion)
    }
    
    static func showAlert(title:String?, message:String, viewController:UIViewController, completion: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: localized(string: "OK"), style: UIAlertActionStyle.default, handler: { (action) in
            completion(action)
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func setViewShadow(view:UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: -15, height: 20)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
    }
    
    static func createBasicAuthString(login:String, password:String) -> String {
        let loginString = String(format: "%@:%@", login, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        return "Basic \(loginData.base64EncodedString())"
    }        
    
    static func uniqueFilename(prefix: String? = nil) -> String {
        let uniqueString = "\(NSDate().timeIntervalSince1970)"
        if prefix != nil {
            return "\(prefix!)-\(uniqueString)"
        }
        
        return uniqueString
    }
    
    static func thumbnailForVideoAtURL(fileName: String) -> UIImage? {
        
        var url = EPLHelper.getFileURL(fileName: fileName)
        url.appendPathExtension("MOV")
        let asset = AVURLAsset(url: url, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(1, 60), actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }
    
    
    static func getFileURLStr(fileName:String) -> String {
        return getFileURL(fileName:fileName).absoluteString
    }
    
    static func getFileURL(fileName:String) -> URL {
        let path = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        return path.appendingPathComponent(fileName)
    }
    
    static func canUploadFiles() -> Bool {
        if Reachability.init()?.currentReachabilityStatus == Reachability.NetworkStatus.reachableViaWiFi {
            return true
        } else {
            return !EPLUserPreferencesHelper.isOnlyWifi()
        }
    }
}
