//
//  MainViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 20/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import KYDrawerController

class MainViewController: KYDrawerController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDrawer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func setupDrawer() {        
        let menuViewController  = MenuViewController()
        let cameraViewController = CameraViewController()
        self.mainViewController = cameraViewController
        self.drawerViewController = menuViewController
    }

}
