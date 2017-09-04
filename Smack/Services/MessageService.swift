//
//  MessageService.swift
//  Smack
//
//  Created by Sean Perez on 9/2/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    var channels = [Channel]()
    var selectedChannel: Channel?
    
    func getAllChannels(completionHandler: @escaping Constants.CompletionHandler) {
        Alamofire.request(Constants.URL.getChannels, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.Headers.tokenHeader).responseJSON { response in
            guard response.result.error == nil else {
                completionHandler(false)
                print(response.result.error as Any)
                return
            }
            guard let data = response.data else { return }
            do {
                self.channels = try JSONDecoder().decode([Channel].self, from: data)
            } catch let error {
                debugPrint(error as Any)
            }
            NotificationCenter.default.post(name: Constants.Notifications.channelsLoaded, object: nil)
            completionHandler(true)
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
}
