//
//  SocketService.swift
//  Smack
//
//  Created by Sean Perez on 9/2/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket = SocketIOClient(socketURL: URL(string: Constants.URL.BaseUrl)!)
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(_ channelName: String, channelDescription: String, completionHandler: @escaping Constants.CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completionHandler(true)
    }
    
    func getChannel(completionHandler: @escaping Constants.CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String, let channelDescription = dataArray[1] as? String, let id = dataArray[2] as? String else { return }
            let newChannel = Channel(_id: id, name: channelName, description: channelDescription, __v: nil)
            MessageService.instance.channels.append(newChannel)
            completionHandler(true)
        }
    }
    
    func addMessage(_ messageBody: String, _ userId: String, _ channelId: String, completionHandler: @escaping Constants.CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completionHandler(true)
    }
    
    func getChatMessage(completionHandler: @escaping Constants.CompletionHandler) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String, let userId = dataArray[1] as? String, let channelId = dataArray[2] as? String, let userName = dataArray[3] as? String, let userAvatar = dataArray[4] as? String, let userAvatarColor = dataArray[5] as? String, let id = dataArray[6] as? String, let timeStamp = dataArray[7] as? String else { return }
            if channelId == MessageService.instance.selectedChannel?._id && AuthService.instance.isLoggedIn {
                let newMessage = Message(_id: id, messageBody: messageBody, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, __v: nil, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandler(typingUsers)
        }
    }
    
}
