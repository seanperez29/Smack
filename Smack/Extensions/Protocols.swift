//
//  Protocols.swift
//  Smack
//
//  Created by Sean Perez on 9/2/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

protocol ViewControllerIsDismissableByTap where Self: UIGestureRecognizerDelegate {
    func registerForViewControllerDismissal()
}
