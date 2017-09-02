//
//  AvatarCell.swift
//  Smack
//
//  Created by Sean Perez on 9/1/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

@IBDesignable
class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    func configureCell(forAvatarColor color: AvatarColor, atIndex index: Int) {
        if color == .dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImage.image = UIImage(named: "light\(index)")
            layer.backgroundColor = UIColor.darkGray.cgColor
        }
    }
}
