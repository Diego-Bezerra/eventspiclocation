//
//  LoginViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 16/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: EPLBaseViewController, UITextFieldDelegate {

    @IBOutlet weak var txtLogin: EPLTextField!
    @IBOutlet weak var txtPassword: EPLTextField!
    @IBOutlet weak var swtKeepConnected: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func setup() {
        self.txtLogin.delegate = self
        self.txtPassword.delegate = self
    }
    
    func validateUser() {
    
        let hudPoint = CGPoint(x: 0, y: 100)
        
        guard let userLogin = self.txtLogin.text, !userLogin.isEmpty else {
            EPLHelper.showHud(withView: self.view, localizedMessage: "EMPTY_LOGIN", andOffSetPoint: hudPoint)
            return
        }
        guard let userPassword = self.txtPassword.text, !userPassword.isEmpty else {
            EPLHelper.showHud(withView: self.view, localizedMessage: "EMPTY_PASSWORD", andOffSetPoint: hudPoint)
            return
        }
        
        EPLHelper.showProgress(withView: self.view)
        ApiService.doLogin(login: userLogin, password: userPassword) { [weak self] (isLogged) in
            guard let s = self else {
                return
            }
            if isLogged {
                s.setUserPreferences()
                s.openNextViewController()
            } else {
                EPLHelper.showHud(withView: s.view
                    , localizedMessage: "WRONG_LOGIN_PASSWORD"
                    , andOffSetPoint: hudPoint)
            }
            EPLHelper.hideProgress(withView: s.view)
        }
    }
    
    func setUserPreferences() {
        EPLUserPreferencesHelper.setUserLogin(login: self.txtLogin.text!, password: self.txtPassword.text!)
        EPLUserPreferencesHelper.setKeepConnected(keepConnected: swtKeepConnected.isOn)
    }
    
    func openNextViewController() {
        if let mainView = (UIApplication.shared.delegate as? AppDelegate)?.mainView {
            self.present(mainView, animated: true, completion: nil)
        }
    }
    
    func enterApp() {
        dismissKeyboard()
        validateUser()
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func forgotLoginPasswordAction(_ sender: Any) {
        let recoverViewController = RecoverPasswordViewController(nibName: "RecoverPasswordViewController", bundle: nil)
        self.present(recoverViewController, animated: true, completion: nil)
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
