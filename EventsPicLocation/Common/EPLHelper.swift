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
    
    static func showProgress(withView view:UIView) {
        //DispatchQueue.main.async {
            MBProgressHUD.showAdded(to:view , animated: true)
        //}
    }
    
    static func hideProgress(withView view:UIView) {
       //DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
        
        //}
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
    
    static func setImage(imageView:UIImageView, url:String?) {
        
        guard let urlStr = url else {
            imageView.image = UIImage(named: "warning")
            return
        }
        
        let url = URL(string: urlStr)
        let imagePlaceHolder = UIImage(named: "picture")
        
        imageView.sd_setImage(with: url
            , placeholderImage: imagePlaceHolder
        , options: SDWebImageOptions.cacheMemoryOnly) { (image, error, cacheType, url) in
            if error != nil {
                imageView.image = UIImage(named: "warning")
            }
        }
    }
    
    static func uniqueFilename(prefix: String? = nil) -> String {
        let uniqueString = ProcessInfo.processInfo.globallyUniqueString
        
        if prefix != nil {
            return "\(prefix!)-\(uniqueString)"
        }
        
        return uniqueString
    }
}
