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
    
    func updateAvatarColor(_ avatarColor: String) {
        self.avatarColor = avatarColor
    }
    
    func logoutUser() {
        id = ""
        avatarColor = ""
        avatarName = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }
    
    func returnUIColor(_ components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        var red, green, blue, alpha: NSString?
        scanner.scanUpToCharacters(from: comma, into: &red)
        scanner.scanUpToCharacters(from: comma, into: &green)
        scanner.scanUpToCharacters(from: comma, into: &blue)
        scanner.scanUpToCharacters(from: comma, into: &alpha)
        guard let unwrappedRed = red, let unwrappedGreen = green, let unwrappedBlue = blue, let unwrappedAlpha = alpha else {
            return UIColor.lightGray
        }
        let redFloat = CGFloat(unwrappedRed.doubleValue)
        let greenFloat = CGFloat(unwrappedGreen.doubleValue)
        let blueFloat = CGFloat(unwrappedBlue.doubleValue)
        let alphaFloat = CGFloat(unwrappedAlpha.doubleValue)
        return UIColor(red: redFloat, green: greenFloat, blue: blueFloat, alpha: alphaFloat)
    }
}
