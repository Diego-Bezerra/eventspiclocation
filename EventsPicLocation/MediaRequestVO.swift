//
//  MediaVO.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 26/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import ObjectMapper

class MediaRequestVO : Mappable {
    
    var login:String?
    var latitude:Double?
    var longitude:Double?
    var idSorteio:Int64?
    var idAssunto:Int64?
    var dataHora:NSDate?
    var midia:Media?
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        
    }
    
//    @NSManaged public var date: NSDate?
//    @NSManaged public var id: Int64
//    @NSManaged public var lat: Double
//    @NSManaged public var lng: Double
//    @NSManaged public var file: String?
//    @NSManaged public var subject: Subject?
//    @NSManaged public var lottery: Lottery?
//    @NSManaged public var user: User?
    
    func saveToCoreData() {
        
        //Subject.fin
        
        if let idSort = self.idSorteio, let idAssunto = self.idAssunto {
            if let model = Subject.findOrCreate(["subject" : idSort, "lottery" : idAssunto]) as? Media {
                model.date = self.dataHora
                model.lat = self.latitude ?? 0
                model.lng = self.longitude ?? 0
                model.file = self.midia?.file
                //model.subject =
                model.save()
            }
        }
    }
}
