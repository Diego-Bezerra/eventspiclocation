//
//  ServiceApiUtil.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 11/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation

class ServiceApiUtil {
    
    static let API_SERVER = "https://pesorte.herokuapp.com"
    static let LIST_LOTTERY_SUBJECT = "/filtro/listar"
    static let LIST_SUBJECT = "/assunto/listar"
    static let LOGIN = "/login"
    static let SAVE_MEDIA = "/midia/salvar"
    static let GET_FILE = "/midia/arquivo/"
    static let SAVE_FILE = "/midia/arquivo/"
    static let CHANGE_PASSWORD = "/usuario/alterarSenha"
    static let RECOVER_PASSWORD = "/usuario/recuperarSenha"
    
    public static func getUrl(urlStr:String) -> URL! {
        return URL(string: "\(ServiceApiUtil.API_SERVER)\(urlStr)")
    }
}
