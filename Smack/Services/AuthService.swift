//
//  AuthService.swift
//  Smack
//
//  Created by Sean Perez on 9/1/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    
    static let instance = AuthService()
    let defaults = UserDefaults.standard
    var isLoggedIn: Bool  {
        get {
            return defaults.bool(forKey: Constants.UserDefaults.loggedInKey)
        } set {
            defaults.set(newValue, forKey: Constants.UserDefaults.loggedInKey)
        }
    }
    var authToken: String {
        get {
            return defaults.value(forKey: Constants.UserDefaults.tokenKey) as! String
        } set {
            defaults.set(newValue, forKey: Constants.UserDefaults.tokenKey)
        }
    }
    var userEmail: String {
        get {
            return defaults.value(forKey: Constants.UserDefaults.userEmail) as! String
        } set {
            defaults.set(newValue, forKey: Constants.UserDefaults.userEmail)
        }
    }
    
    func registerUser(_ email: String, _ password: String, completionHandler: @escaping Constants.CompletionHandler) {
        let header = ["Content-Type": "application/json; charset=utf-8"]
        let body: [String: Any] = ["email": email.lowercased(), "password": password]
        Alamofire.request(Constants.URL.urlRegister, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { response in
            guard response.result.error == nil else {
                completionHandler(false)
                debugPrint(response.result.error as Any)
                return
            }
            completionHandler(true)
        }
        
    }
    
}
