//
//  UserPreferencesUtil.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 16/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation

class EPLUserPreferencesHelper {
    
    static let USER_LOGIN_PASS_KEY = "userLoginKey"
    static let KEEP_CONNECTED_KEY = "keepConnected"
    static let ONLY_WIFI_KEY = "onlyWifi"
    
    static func isUserLogged() -> Bool {
        guard let auth = UserDefaults.standard.string(forKey: USER_LOGIN_PASS_KEY) else {
            return false
        }
        return !auth.isEmpty && isKeepLogged()
    }
    
    static func getUserAuth() -> String? {
        return UserDefaults.standard.string(forKey: USER_LOGIN_PASS_KEY)
    }
    
    static func setUserLogin(login:String, password:String) {
        let basicAuth = EPLHelper.createBasicAuthString(login: login, password: password)
        UserDefaults.standard.setValue(basicAuth, forKey: USER_LOGIN_PASS_KEY)
    }
    
    static func isKeepLogged() -> Bool {
        return UserDefaults.standard.bool(forKey: KEEP_CONNECTED_KEY)
    }
    
    static func setKeepLogged(keepConnected:Bool) {
        UserDefaults.standard.set(keepConnected, forKey: KEEP_CONNECTED_KEY)
    }
    
    static func setOnlyWifi(onlyWifi:Bool) {
        UserDefaults.standard.set(onlyWifi, forKey: ONLY_WIFI_KEY)
    }
    
    static func isOnlyWifi() -> Bool {
        return UserDefaults.standard.bool(forKey: ONLY_WIFI_KEY)
    }
}
