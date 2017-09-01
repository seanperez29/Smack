//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Sean Perez on 8/31/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants.Identifiers.undwindToChannel, sender: nil)
    }
}
