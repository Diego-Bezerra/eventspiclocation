//
//  MediaVO.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 26/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import ObjectMapper

class MediaVO : Mappable {

    var extensao:String?
    var arquivo:String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}

