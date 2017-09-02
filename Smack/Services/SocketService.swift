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
    
}
