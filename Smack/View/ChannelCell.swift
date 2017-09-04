//
//  ChannelCell.swift
//  Smack
//
//  Created by Sean Perez on 9/2/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelNameLabel: UILabel!
    
    func configureCell(_ channel: Channel) {
        channelNameLabel.text = "#\(channel.name)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
            UIView.animate(withDuration: 0.5) {
                self.setSelected(false, animated: true)
            }
        } else {
            layer.backgroundColor = UIColor.clear.cgColor
        }
    }

}
