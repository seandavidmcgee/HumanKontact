//
//  PagedViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 4/6/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

class PagingViewController1: PagingViewController0, UITextFieldDelegate {
    
    override func viewDidLoad() {
        
        var arrayFirstRow = ["B", "I", "V"]
        var arraySecondRow = ["H", "D", "A"]
        var arrayThirdRow = ["N", "P", "B"]
        var arrayOfTagsFirst = [66, 73, 86]
        var arrayOfTagsSecond = [72, 68, 65]
        var arrayOfTagsThird = [78, 80, 66]
        var buttonXFirst: CGFloat = 0
        var buttonXSecond: CGFloat = 0
        var buttonXThird: CGFloat = 0
        var buttonTagFirst: Int = 0
        var buttonTagSecond: Int = 0
        var buttonTagThird: Int = 0
        
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
        
        for key in arraySecondRow {
            
            let keyButton2 = UIButton(frame: CGRect(x: buttonXSecond, y: 72, width: 52, height: 52))
            buttonXSecond = buttonXSecond + 62
            
            keyButton2.layer.cornerRadius = 0
            keyButton2.layer.borderWidth = 1
            keyButton2.setTitleColor(UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ), forState: UIControlState.Normal)
            keyButton2.layer.borderColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ).CGColor;
            keyButton2.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
            keyButton2.setTitle("\(key)", forState: UIControlState.Normal)
            keyButton2.titleLabel!.text = "\(key)"
            keyButton2.tag = arrayOfTagsSecond[buttonTagSecond]
            buttonTagSecond = buttonTagSecond++
            keyButton2.addTarget(self, action: "buttonHighlight:", forControlEvents: UIControlEvents.TouchDown);
            keyButton2.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchUpInside);
            keyButton2.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpOutside);
            
            self.view.addSubview(keyButton2)
        }

        for key in arrayThirdRow {
            
            let keyButton3 = UIButton(frame: CGRect(x: buttonXThird, y: 134, width: 52, height: 52))
            buttonXThird = buttonXThird + 62
            
            keyButton3.layer.cornerRadius = 0
            keyButton3.layer.borderWidth = 1
            keyButton3.setTitleColor(UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ), forState: UIControlState.Normal)
            keyButton3.layer.borderColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ).CGColor;
            keyButton3.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
            keyButton3.setTitle("\(key)", forState: UIControlState.Normal)
            keyButton3.titleLabel!.text = "\(key)"
            keyButton3.tag = arrayOfTagsThird[buttonTagThird]
            buttonTagThird = buttonTagThird++
            keyButton3.addTarget(self, action: "buttonHighlight:", forControlEvents: UIControlEvents.TouchDown);
            keyButton3.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchUpInside);
            keyButton3.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpOutside);
            
            self.view.addSubview(keyButton3)
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