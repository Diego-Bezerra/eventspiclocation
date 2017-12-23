//
//  SettingsViewController.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 10/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit

class SettingsViewController: EPLBaseViewController {
    
    @IBOutlet weak var keepLoggedSwt: UISwitch!
    @IBOutlet weak var onlyWifiSwt: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("SETTINGS", comment: "")
        self.setupViews()
    }
    
    func setupViews()  {
        keepLoggedSwt.isOn = EPLUserPreferencesHelper.isKeepLogged()
        onlyWifiSwt.isOn = EPLUserPreferencesHelper.isOnlyWifi()
    }
    
    
   @IBAction func keepLoggedTapped(_ sender: UISwitch) {
        EPLUserPreferencesHelper.setKeepLogged(keepConnected: sender.isOn)
    }
    
    @IBAction func onlyWifiTapped(_ sender: UISwitch) {
        EPLUserPreferencesHelper.setOnlyWifi(onlyWifi: sender.isOn)
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
        appDelegate.window?.rootViewController = LoginViewController()
    }
    
}
