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
        let addChannelVC = AddChannelVC()
        addChannelVC.modalPresentationStyle = .custom
        present(addChannelVC, animated: true, completion: nil)
    }
    
    
    @objc func userDataDidChange(_ notification: Notification) {
        setupUserInfo()
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
}
