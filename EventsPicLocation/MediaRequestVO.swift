//
//  MediaVO.swift
//  EventsPicLocation
//
//  Created by Diego on 26/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import ObjectMapper

class MediaRequestVO : Mappable {
    
    var id:Int?
    var login:String?
    var usuario:String?
    var latitude:Double?
    var longitude:Double?
    var idSorteio:Int64?
    var idAssunto:Int64?
    var dataHora:Date?
    var mimeType:String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        usuario <- map["usuario"]
        login <- map["login"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        idSorteio <- map["idSorteio"]
        idAssunto <- map["idAssunto"]
        mimeType <- map["mimeType"]
        
        if let d = dataHora {
            //2017-10-04 20:18:23
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd hh:mm:ss"
            var dateStr = df.string(from: d)
            
            dateStr <- map["dataHora"]
        }
    }
}
