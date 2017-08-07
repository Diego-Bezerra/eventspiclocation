//
//  EPLButton.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 16/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit

class EPLButton: UIButton {

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if let title = self.title(for: UIControlState.normal) {
            self.setTitle(EPLHelper.localized(string: title), for: UIControlState.normal)
        }
    }
    
}
