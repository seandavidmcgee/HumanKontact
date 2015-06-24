//
//  Store.swift
//  keyboardTest
//
//  Created by Sean McGee on 6/15/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit
import Foundation

protocol StoreDelegate {
    func didPressButton(button:UIButton)
}

class Store: UIButton {
    var connectBtnImages: [UIImage!] = [UIImage(named:"CallHome"), UIImage(named:"CallMobile"), UIImage(named:"CallWork"), UIImage(named:"Messaging"), UIImage(named:"Email")]
    var connectBtnX: CGFloat = 74
    var type: Int! = nil
    var actionToSend: String! = nil
    
    var delegate:StoreDelegate!
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.addBtns()
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    func addBtns() {
            var connectBtn = UIButton()
            connectBtn = UIButton(frame: CGRect(x: connectBtnX, y: 28, width: 36, height: 36))
            connectBtn.setImage(connectBtnImages[0], forState: UIControlState.Normal)
            connectBtn.layer.cornerRadius = connectBtn.frame.width / 2.0
            connectBtn.contentMode = UIViewContentMode.ScaleAspectFit
            connectBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
            connectBtn.setTitle(actionToSend, forState: UIControlState.Normal)
            connectBtn.addTarget(self, action: "buttonPress:", forControlEvents: .TouchUpInside)
            connectBtnX = connectBtnX + 60
            addSubview(connectBtn)
    }
    
    func buttonPress(button:UIButton) {
        delegate.didPressButton(button)
    }
}


