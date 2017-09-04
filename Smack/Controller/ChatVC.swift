//
//  ChatVC.swift
//  Smack
//
//  Created by Sean Perez on 8/30/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: Constants.Notifications.userDataDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: Constants.Notifications.channelSelected, object: nil)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { success in
                NotificationCenter.default.post(name: Constants.Notifications.userDataDidChange, object: nil)
            }
        }
    }
    
    @objc func userDataDidChange(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log In"
        }
    }
    
    @objc func channelSelected(_ notification: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLabel.text = "#\(channelName)"
    }
    
    func onLoginGetMessages() {
        MessageService.instance.getAllChannels { success in
            if success {
                // Do stuff with channel
            }
        }
    }

}

