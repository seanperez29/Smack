//
//  UserDataService.swift
//  Smack
//
//  Created by Sean Perez on 9/1/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    private(set) var id = ""
    private(set) var avatarColor = ""
    private(set) var avatarName = ""
    private(set) var email = ""
    private(set) var name = ""
    
    func setUserData(_ id: String, _ name: String, _ email: String, _ avatarColor: String, _ avatarName: String) {
        self.id = id
        self.name = name
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
    }
    
    func updateAvatarName(_ avatarName: String) {
        self.avatarName = avatarName
    }
}
