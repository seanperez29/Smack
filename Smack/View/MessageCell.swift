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
        var isoDate = message.timeStamp
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLabel.text = finalDate
        }
    }

}
