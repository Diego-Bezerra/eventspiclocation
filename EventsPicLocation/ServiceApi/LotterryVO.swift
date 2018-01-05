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
    
    func findOrCreate() -> Lottery? {
        var lottery:Lottery?
        if let selfId = self.id {
            if let model = Lottery.findOrCreate(["id" : selfId]) as? Lottery {
                model.mDescription = self.mDescription
                lottery = model
            }
        }
        
        return lottery
    }
}
