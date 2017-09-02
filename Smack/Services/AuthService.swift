//
//  AuthService.swift
//  Smack
//
//  Created by Sean Perez on 9/1/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
    
    func registerUser(_ email: String, _ password: String, _ name: String, completionHandler: @escaping Constants.CompletionHandler) {
        let body: [String: Any] = ["email": email.lowercased(), "password": password]
        Alamofire.request(Constants.URL.urlRegister, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Constants.Headers.standardHeader).responseString { response in
            guard response.result.error == nil else {
                completionHandler(false)
                debugPrint(response.result.error as Any)
                return
            }
            self.loginUser(email, password, true, name, completionHandler: completionHandler)
        }
    }
    
    func loginUser(_ email: String, _ password: String, _ isNewUser: Bool, _ name: String? = nil, completionHandler: @escaping Constants.CompletionHandler) {
        let body: [String: Any] = ["email": email.lowercased(), "password": password]
        Alamofire.request(Constants.URL.urlLogin, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Constants.Headers.standardHeader).responseJSON { response in
            guard response.result.error == nil else {
                print("error here")
                completionHandler(false)
                debugPrint(response.result.error as Any)
                return
            }
            guard let data = response.data else { return }
            let json = JSON(data: data)
            self.userEmail = json["user"].stringValue
            self.authToken = json["token"].stringValue
            self.isLoggedIn = true
            if isNewUser {
                guard let name = name else { return }
                self.createUser(name, email, completionHandler: completionHandler)
            } else {
                self.findUserByEmail(completionHandler: completionHandler)
            }
        }
    }
    
    func createUser(_ name: String, _ email: String, completionHandler: @escaping Constants.CompletionHandler) {
        let body: [String: Any] = ["name": name, "email": email.lowercased(), "avatarName": UserDataService.instance.avatarName, "avatarColor": UserDataService.instance.avatarColor]
        Alamofire.request(Constants.URL.createUser, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Constants.Headers.tokenHeader).responseJSON { response in
            guard response.result.error == nil else {
                completionHandler(false)
                debugPrint(response.result.error as Any)
                return
            }
            guard let data = response.data else { return }
            self.setUserInfo(data: data)
            completionHandler(true)
        }
    }
    
    func findUserByEmail(completionHandler: @escaping Constants.CompletionHandler) {
        Alamofire.request("\(Constants.URL.findUserByEmail)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.Headers.tokenHeader).responseJSON { response in
            guard response.result.error == nil else {
                completionHandler(false)
                debugPrint(response.result.error as Any)
                return
            }
            guard let data = response.data else { return }
            self.setUserInfo(data: data)
            completionHandler(true)
        }
    }
    
    func setUserInfo(data: Data) {
        let json = JSON(data: data)
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        UserDataService.instance.setUserData(id, name, email, avatarColor, avatarName)
    }
}
