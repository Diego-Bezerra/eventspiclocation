//
//  RecoverPasswordViewController.swift
//  EventsPicLocation
//
//  Created by Diego on 31/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit

class RecoverPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var login: EPLTextField!
    @IBOutlet weak var email: EPLTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = EPLHelper.localized(string: "RECOVER_PASSWORD")
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: EPLHelper.localized(string: "CLOSE")
            , style: UIBarButtonItemStyle.done
            , target: self, action: #selector(dismissViewController))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func validate() {
        
        let hudPoint = CGPoint(x: 0, y: 100)
        
        guard let userLogin = self.login.text, !userLogin.isEmpty else {
            EPLHelper.showHud(withView: self.view, localizedMessage: "EMPTY_LOGIN", andOffSetPoint: hudPoint)
            return
        }
        guard let userEmail = self.email.text, !userEmail.isEmpty else {
            EPLHelper.showHud(withView: self.view, localizedMessage: "EMPTY_EMAIL", andOffSetPoint: hudPoint)
            return
        }
        EPLHelper.showProgress(withView: self.view)
        ApiService.recoverPassword(login: userLogin, email: userEmail) { [unowned self] (sentEmail) in
            if sentEmail {
                EPLHelper.showAlert(message: EPLHelper.localized(string: "VERIFY_EMAIL"), viewController: self, completion: { (action) in
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
                EPLHelper.showHud(withView: self.view, andLocalizedMessage: EPLHelper.localized(string: "GENERIC_PROBLEM"))
            }
            
            EPLHelper.hideProgress(withView: self.view)
        }
    }
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func recoverAction(_ sender: Any) {
        dismissKeyboard()
        validate()
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
