//
//  SubjectVO.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 11/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import ObjectMapper

class SubjectVO : Mappable {
    
    var id: Int64?
    var mDescription: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        mDescription <- map["descricao"]
    }
    
    func findOrCreate() -> Subject? {
        var subject:Subject?
        if let selfId = self.id {
            if let model = Subject.findOrCreate(["id" : selfId]) as? Subject {
                model.mDescription = self.mDescription
                subject = model
            }
        }
        
        return subject
    }
    
}
