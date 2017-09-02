//
//  LoginVC.swift
//  Smack
//
//  Created by Sean Perez on 8/31/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableActivityIndicator(activityIndicator, false)
        registerForKeyboardDismissal()
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, email != "", let password = passwordTextField.text, password != "" else { return }
        enableActivityIndicator(activityIndicator, true)
        AuthService.instance.loginUser(email, password, false) { success in
            NotificationCenter.default.post(name: Constants.Notifications.userDataDidChange, object: nil)
            self.enableActivityIndicator(self.activityIndicator, false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants.Identifiers.createAccountVC, sender: nil)
    }
    
}
