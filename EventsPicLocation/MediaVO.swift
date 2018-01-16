//
//  MediaVO.swift
//  EventsPicLocation
//
//  Created by Diego on 26/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import ObjectMapper

class MediaVO : Mappable {
    
    var id: Int64?
    var date: NSDate?
    var lat: Double?
    var lng: Double?
    var file: String?
    var mimeType: String?
    var subject: SubjectVO?
    var lottery: LotteryVO?
    var user: User?

    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        date <- map["dataHora"]
        lat <- map["latitude"]
        lng <- map["longitude"]
        mimeType <- map["mimeType"]
        user <- map["usuario"]
    }
}

