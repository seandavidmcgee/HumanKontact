//
//  PagingViewController2.swift
//  keyboardTest
//
//  Created by Sean McGee on 4/6/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

class PagingViewController2:  PagingViewController0, UITextFieldDelegate {
    override func viewDidLoad() {
        var arrayFirstRow = ["O", "J", "W"]
        var arrayOfTagsFirst = [79, 74, 87]
        var buttonXFirst: CGFloat = 0
        var buttonTagFirst: Int = 0
        
        for key in arrayFirstRow {
            
            let keyButton1 = UIButton(frame: CGRect(x: buttonXFirst, y: 10, width: 52, height: 52))
            buttonXFirst = buttonXFirst + 62
            
            keyButton1.layer.cornerRadius = 0
            keyButton1.layer.borderWidth = 1
            keyButton1.setTitleColor(UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ), forState: UIControlState.Normal)
            keyButton1.layer.borderColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ).CGColor;
            keyButton1.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
            keyButton1.setTitle("\(key)", forState: UIControlState.Normal)
            keyButton1.setTitleColor(UIColor(white: 248/255, alpha: 0.5), forState: UIControlState.Highlighted)
            keyButton1.titleLabel!.text = "\(key)"
            keyButton1.tag = arrayOfTagsFirst[buttonTagFirst]
            buttonTagFirst = buttonTagFirst++
            keyButton1.addTarget(self, action: "buttonHighlight:", forControlEvents: UIControlEvents.TouchDown);
            keyButton1.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchUpInside);
            keyButton1.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpOutside);
            
            self.view.addSubview(keyButton1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func buttonHighlight(sender: UIButton!) {
        var btnsendtag:UIButton = sender
        sender.backgroundColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 )
    }
    override func buttonNormal(sender: UIButton!) {
        var btnsendtag:UIButton = sender
        sender.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
    }
}
