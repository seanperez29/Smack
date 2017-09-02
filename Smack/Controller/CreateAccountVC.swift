//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Sean Perez on 8/31/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    var avatarName = "smackProfileIcon"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, email != "", let password = passwordTextField.text, password != "", let name = usernameTextField.text, name != "" else { return }
        AuthService.instance.registerUser(email, password, name) { success in
            if success {
                self.performSegue(withIdentifier: Constants.Identifiers.undwindToChannel, sender: nil)
            }
        }
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {

    }
    
    @IBAction func generateBackgroundColorPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants.Identifiers.undwindToChannel, sender: nil)
    }
    
    
}
