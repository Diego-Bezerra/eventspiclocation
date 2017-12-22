//
//  SettingsViewController.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 10/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit

class SettingsViewController: EPLBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("SETTINGS", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
   @IBAction func keepLoggedTapped(_ sender: Any) {
    
    }
    
    @IBAction func onlyWifiTapped(_ sender: Any) {
        
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
    }
    
}
