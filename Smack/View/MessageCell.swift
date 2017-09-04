//
//  MessageCell.swift
//  Smack
//
//  Created by Sean Perez on 9/4/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!

    func configureCell(_ message: Message) {
        userImage.image = UIImage(named: message.userAvatar)
        messageBodyLabel.text = message.messageBody
        usernameLabel.text = message.userName
        userImage.backgroundColor = UserDataService.instance.returnUIColor(message.userAvatarColor)
    }

}
