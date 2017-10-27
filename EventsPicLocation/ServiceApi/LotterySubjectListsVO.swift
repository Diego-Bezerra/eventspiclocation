//
//  LotterySubjectLists.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 11/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import ObjectMapper

class LotterySubjectListsVO : Mappable {
    
    var lotteries: [LotteryVO]?
    var subjects: [LotteryVO]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        lotteries <- map["sorteios"]
        subjects <- map["assuntos"]
    }
}
