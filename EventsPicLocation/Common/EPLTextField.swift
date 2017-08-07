//
//  EPLTextField.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 16/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit

class EPLTextField: UITextField {

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if let str = self.placeholder {
            self.placeholder = EPLHelper.localized(string: str)
        }
    }

}
