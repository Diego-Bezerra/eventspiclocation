//
//  LotteryRepository.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 23/09/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
class LotteryRepository {
    
    func createNewLottery(description:String)  {
        if let lottery = Lottery.create() as? Lottery {
            lottery.mDescription = description
        }
    }
}
