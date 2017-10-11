//
//  ApiService.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 11/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiService {
    
    func getLotteryAndSubjectList() -> LotterySubjectListsVO? {
        let header = HTTPHeaders(dictionaryLiteral: ("String", "String"))
        
        Alamofire.request(ServiceApiUtil.getUrl(urlStr: ServiceApiUtil.LIST_LOTTERY_SUBJECT)
            , method: HTTPMethod.post
            , parameters: nil
            , encoding: URLEncoding.default
            , headers: header).validate().responseJSON { (response) in
                
                let json = JSON(data: response.data!)
                let vo = LotterySubjectListsVO(JSON: json.dictionary)
        }
                
        
    }
}
