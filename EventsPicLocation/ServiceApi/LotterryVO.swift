//
//  LotterryResponse.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 11/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import ObjectMapper

class LotteryVO : Mappable {
    
    var id: Int64?
    var mDescription: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        mDescription <- map["descricao"]
    }
}
