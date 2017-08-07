//
//  EPLLabel.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 17/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit

class EPLLabel: UILabel {

    override func willMove(toWindow newWindow: UIWindow?) {
        if let text = self.text {
            self.text = EPLHelper.localized(string: text)
        }
    }

}
