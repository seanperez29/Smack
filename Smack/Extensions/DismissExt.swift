//
//  DismissExt.swift
//  Smack
//
//  Created by Sean Perez on 9/1/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

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
    
}

extension ViewControllerIsDismissableByTap where Self: UIViewController {
    func registerForViewControllerDismissal() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissViewController))
        tap.delegate = (self as! UIGestureRecognizerDelegate)
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
}
