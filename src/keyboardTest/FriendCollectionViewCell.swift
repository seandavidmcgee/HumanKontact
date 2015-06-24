//
//  FriendCollectionViewCell.swift
//  keyboardTest
//
//  Created by Sean McGee on 6/15/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit
import Foundation

class FriendCollectionViewCell: UICollectionViewCell {
    var backgroundImageView: UIImageView! = UIImageView()
    var firstNameTitleLabel: UILabel! = UILabel()
    var lastNameTitleLabel: UILabel! = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.contentMode = UIViewContentMode.Center
        self.userInteractionEnabled = true
        
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: 58, height: 58)
        backgroundImageView.layer.cornerRadius = backgroundImageView.frame.width / 2.0
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = UIViewContentMode.ScaleToFill
        backgroundImageView.opaque = true
        contentView.addSubview(backgroundImageView)
        
        firstNameTitleLabel.frame = CGRect(x: 0, y: 58, width: 58, height: 21)
        firstNameTitleLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        firstNameTitleLabel.textColor = UIColor.whiteColor()
        firstNameTitleLabel.textAlignment = .Center
        firstNameTitleLabel.lineBreakMode = .ByTruncatingTail

        contentView.addSubview(firstNameTitleLabel)
        
        lastNameTitleLabel.frame = CGRect(x: 0, y: 74, width: 58, height: 21)
        lastNameTitleLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        lastNameTitleLabel.textColor = UIColor.whiteColor()
        lastNameTitleLabel.textAlignment = .Center
        lastNameTitleLabel.lineBreakMode = .ByTruncatingTail

        contentView.addSubview(lastNameTitleLabel)
        self.addSubview(contentView)
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
    }
}