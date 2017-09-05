//
//  ChannelVC.swift
//  Smack
//
//  Created by Sean Perez on 8/31/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func prepareForUnwind(_ segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - (self.view.frame.size.width * 0.17)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: Constants.Notifications.userDataDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: Constants.Notifications.channelsLoaded, object: nil)
        SocketService.instance.getChannel { success in
            self.tableView.reloadData()
        }
        SocketService.instance.getChatMessage { message in
            if message.channelId != MessageService.instance.selectedChannel?._id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(message.channelId)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInfo()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: Constants.Identifiers.loginVC, sender: nil)
        }
    }
    
    @IBAction func addChanelButtonPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannelVC = AddChannelVC()
            addChannelVC.modalPresentationStyle = .custom
            present(addChannelVC, animated: true, completion: nil)
        }
    }
    
    
    @objc func userDataDidChange(_ notification: Notification) {
        setupUserInfo()
    }
    
    @objc func channelsLoaded(_ notification: Notification) {
        tableView.reloadData()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImage.image = #imageLiteral(resourceName: "smackProfileIcon")
            userImage.backgroundColor = .clear
            tableView.reloadData()
        }
    }

}

extension ChannelVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.ChannelCell, for: indexPath) as! ChannelCell
        let channel = MessageService.instance.channels[indexPath.row]
        cell.configureCell(channel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChannel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = selectedChannel
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{ $0 != selectedChannel._id }
        }
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        NotificationCenter.default.post(name: Constants.Notifications.channelSelected, object: nil)
        self.revealViewController().revealToggle(animated: true)
    }

}
