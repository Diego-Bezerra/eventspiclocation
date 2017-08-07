//
//  LoginViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 16/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtLogin: EPLTextField!
    @IBOutlet weak var txtPassword: EPLTextField!
    @IBOutlet weak var swtKeepConnected: UISwitch!
    
    //MOCK
    let login = "diego"
    let password = "vai"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func setup() {
        self.txtLogin.delegate = self
        self.txtPassword.delegate = self
    }
    
    func validateUser() -> Bool {
        //do the logic to send to the web service
    
        let hudPoint = CGPoint(x: 0, y: 100)
        
        guard let userLogin = self.txtLogin.text?.uppercased(), !userLogin.isEmpty else {
            EPLHelper.showHud(withView: self.view, localizedMessage: "EMPTY_LOGIN", andOffSetPoint: hudPoint)
            return false
        }
        guard let userPassword = self.txtPassword.text?.uppercased(), !userPassword.isEmpty else {
            EPLHelper.showHud(withView: self.view, localizedMessage: "EMPTY_PASSWORD", andOffSetPoint: hudPoint)
            return false
        }
        guard userLogin == login.uppercased() && userPassword == password.uppercased() else {
            EPLHelper.showHud(withView: self.view, localizedMessage: "WRONG_LOGIN_PASSWORD", andOffSetPoint: hudPoint)
            return false
        }
        
        return true
        
    }
    
    func setUserPreferences() {
        EPLUserPreferencesHelper.setUserLogin(login: self.txtLogin.text!)
        EPLUserPreferencesHelper.setKeepConnected(keepConnected: swtKeepConnected.isOn)
    }
    
    func openCameraViewController() {
        let cameraViewController = CameraViewController()
        self.present(cameraViewController, animated: true, completion: nil)
    }
    
    func enterApp() {
        dismissKeyboard()
        if validateUser() {
            setUserPreferences()
            openCameraViewController()
        }
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func enterAction(_ sender: Any) {
        enterApp()
    }
    
    @IBAction func keyboadEnterAction(_ sender: Any) {
        enterApp()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        self.txtPassword.becomeFirstResponder()
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
