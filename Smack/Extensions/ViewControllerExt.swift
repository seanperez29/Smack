//
//  ViewControllerExt.swift
//  Smack
//
//  Created by Sean Perez on 9/1/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func registerForKeyboardDismissal() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func enableActivityIndicator(_ activityIndicator: UIActivityIndicatorView, _ enabled: Bool) {
        activityIndicator.isHidden = !enabled
        enabled ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = !enabled
    }
    
}

extension ViewControllerIsDismissableByTap where Self: UIViewController {
    func registerForViewControllerDismissal() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissViewController))
        tap.delegate = (self as! UIGestureRecognizerDelegate)
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
}
