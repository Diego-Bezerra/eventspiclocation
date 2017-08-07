//
//  UserPreferencesUtil.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 16/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation

class EPLUserPreferencesHelper {
    
    static let USER_LOGIN_KEY = "userLoginKey"
    static let KEEP_CONNECTED_KEY = "keepConnected"
    
    static func isUserLogged() -> Bool {
        guard let login = UserDefaults.standard.string(forKey: USER_LOGIN_KEY) else {
            return false
        }
        return !login.isEmpty && isToKeepConnected()
    }
    
    static func setUserLogin(login:String) {
        UserDefaults.standard.setValue(login, forKey: USER_LOGIN_KEY)
    }
    
    static func isToKeepConnected() -> Bool {
        return UserDefaults.standard.bool(forKey: KEEP_CONNECTED_KEY)
    }
    
    static func setKeepConnected(keepConnected:Bool) {
        UserDefaults.standard.set(keepConnected, forKey: KEEP_CONNECTED_KEY)
    }
}
