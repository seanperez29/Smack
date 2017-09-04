//
//  Message.swift
//  Smack
//
//  Created by Sean Perez on 9/3/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

struct Message: Decodable {
    
    private(set) var _id: String
    private(set) var messageBody: String
    private(set) var userId: String
    private(set) var channelId: String
    private(set) var userName: String
    private(set) var userAvatar: String
    private(set) var userAvatarColor: String
    private(set) var __v: String?
    private(set) var timeStamp: String

}
