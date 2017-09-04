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
        static let avatarPickerVC = "avatarPickerVC"
    }
    
    struct UserDefaults {
        static let loggedInKey = "loggedIn"
        static let tokenKey = "token"
        static let userEmail = "userEmail"
    }
    
    struct URL {
        static let BaseUrl = "https://smackcloneapp.herokuapp.com/v1/"
        static let urlRegister = "\(Constants.URL.BaseUrl)account/register"
        static let urlLogin = "\(Constants.URL.BaseUrl)account/login"
        static let createUser = "\(Constants.URL.BaseUrl)user/add"
        static let findUserByEmail = "\(Constants.URL.BaseUrl)user/byEmail/"
        static let getChannels = "\(Constants.URL.BaseUrl)channel"
    }
    
    struct Headers {
        static let standardHeader = ["Content-Type": "application/json; charset=utf-8"]
        static let tokenHeader = ["Authorization": "Bearer \(AuthService.instance.authToken)", "Content-Type": "application/json; charset=utf-8"]
    }
    
    struct Cells {
        static let AvatarCell = "AvatarCell"
        static let ChannelCell = "ChannelCell"
    }
    
    struct Notifications {
        static let userDataDidChange = Notification.Name("userDataDidChange")
        static let channelsLoaded = Notification.Name("channelsLoaded")
        static let channelSelected = Notification.Name("channelSelected")
    }
    
}
