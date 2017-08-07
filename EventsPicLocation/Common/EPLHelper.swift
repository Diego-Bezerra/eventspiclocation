//
//  Helper.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 16/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import MBProgressHUD

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
        MBProgressHUD.showAdded(to:view , animated: true)
    }
    
    static func hideProgress(withView view:UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
