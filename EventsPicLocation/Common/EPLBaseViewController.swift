//
//  EPLBaseViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 08/08/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import KYDrawerController

class EPLBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        
    }
    
    func toggleDrawer() {
        if let mainView = (UIApplication.shared.delegate as? AppDelegate)?.mainView {
            mainView.setDrawerState(mainView.drawerState == .opened ? .closed : .opened, animated: true)
        }
    }
}
