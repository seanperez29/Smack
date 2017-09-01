//
//  Constants.swift
//  Smack
//
//  Created by Sean Perez on 8/31/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

struct Constants {
    
    typealias CompletionHandler = (_ Success: Bool) -> ()
    
    struct Identifiers {
        static let loginVC = "loginVC"
        static let createAccountVC = "createAccountVC"
        static let undwindToChannel = "unwindToChannel"
    }
    
    struct UserDefaults {
        static let loggedInKey = "loggedIn"
        static let tokenKey = "token"
        static let userEmail = "userEmail"
    }
    
    struct URL {
        static let BaseUrl = "https://smackcloneapp.herokuapp.com/v1/"
        static let urlRegister = "\(Constants.URL.BaseUrl)account/register"
    }
    
}
