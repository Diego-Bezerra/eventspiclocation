//
//  EditionRepository.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 23/09/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
class EditionRepository {
    
    func createNewEdition(description:String)  {
        if let edition = Lottery.create() as? Edition {
            edition.mDescription = description
        }
    }
}
