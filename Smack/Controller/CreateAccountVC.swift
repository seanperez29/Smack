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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardDismissal()
        enableActivityIndicator(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            if UserDataService.instance.avatarName.contains("light") && bgColor == nil {
                userImage.backgroundColor = .darkGray
            } else if UserDataService.instance.avatarName.contains("dark") && bgColor == nil {
                userImage.backgroundColor = .lightGray
            }
        }
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        enableActivityIndicator(true)
        guard let email = emailTextField.text, email != "", let password = passwordTextField.text, password != "", let name = usernameTextField.text, name != "" else { return }
        AuthService.instance.registerUser(email, password, name) { success in
            if success {
                self.enableActivityIndicator(false)
                self.performSegue(withIdentifier: Constants.Identifiers.undwindToChannel, sender: nil)
                NotificationCenter.default.post(name: Constants.Notifications.userDataDidChange, object: nil)
            }
        }
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants.Identifiers.avatarPickerVC, sender: nil)
    }
    
    @IBAction func generateBackgroundColorPressed(_ sender: Any) {
        var colorArray = [CGFloat]()
        for _ in 0...2 {
            let randomNumber = CGFloat(arc4random_uniform(255)) / 255
            colorArray.append(randomNumber)
        }
        bgColor = UIColor(red: colorArray[0], green: colorArray[1], blue: colorArray[2], alpha: 1.0)
        UIView.animate(withDuration: 0.2) {
            self.userImage.backgroundColor = self.bgColor
        }
    }
    
    func enableActivityIndicator(_ enabled: Bool) {
        activityIndicator.isHidden = !enabled
        enabled ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = !enabled
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants.Identifiers.undwindToChannel, sender: nil)
    }
    
}
