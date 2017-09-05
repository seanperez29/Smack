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
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var typingInProgressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMessageButton.isHidden = true
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: Constants.Notifications.userDataDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: Constants.Notifications.channelSelected, object: nil)
        view.bindToKeyboard()
        revealViewController().delegate = self
        registerForKeyboardDismissal()
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { success in
                NotificationCenter.default.post(name: Constants.Notifications.userDataDidChange, object: nil)
            }
        }
        SocketService.instance.getChatMessage { success in
            if success {
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        SocketService.instance.getTypingUsers { typingUsers in
            guard let channelId = MessageService.instance.selectedChannel?._id else { return }
            var names = ""
            var numberOfTypers = 0
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingInProgressLabel.text = "\(names) \(verb) typing a message"
            } else {
                self.typingInProgressLabel.text = ""
            }
        }
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func messageEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        if messageTextField.text == "" {
            sendMessageButton.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            sendMessageButton.isHidden = false
            SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
        }
    }
    
    @IBAction func sendMessageButtonPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?._id, let messageBody = messageTextField.text, messageBody != "" else { return }
            SocketService.instance.addMessage(messageBody, UserDataService.instance.id, channelId, completionHandler: { success in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
                }
            })
        }
    }
    
    @objc func userDataDidChange(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    @objc func channelSelected(_ notification: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLabel.text = "#\(channelName)"
        getMessages()
    }
    
    func onLoginGetMessages() {
        MessageService.instance.getAllChannels { success in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        MessageService.instance.getAllMessagesForChannel(channelId) { success in
            self.tableView.reloadData()
        }
    }

}

extension ChatVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.MessageCell, for: indexPath) as! MessageCell
        let message = MessageService.instance.messages[indexPath.row]
        cell.configureCell(message)
        return cell
    }
    
}

extension ChatVC: SWRevealViewControllerDelegate {
    func revealController(_ revealController: SWRevealViewController!, didMoveTo position: FrontViewPosition) {
        if position == .right {
            view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
        } else {
            registerForKeyboardDismissal()
        }
    }
}

