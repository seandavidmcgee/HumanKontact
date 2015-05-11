//
//  PagingViewController0_0.swift
//  keyboardTest
//
//  Created by Sean McGee on 4/7/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

var arrayFirstRow = ["S", "M", "F"]
var arraySecondRow = ["R", "G", "L"]
var arrayThirdRow = ["C", "E", "T"]
var arrayOfTagsFirst = [83, 77, 70]
var arrayOfTagsSecond = [82, 71, 76]
var arrayOfTagsThird = [67, 69, 84]

class PagingViewController0_0: PagingViewController0, UITextFieldDelegate {
    
    override func viewDidLoad() {

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
            keyButton1.addTarget(self, action: "buttonHighlight:", forControlEvents: UIControlEvents.TouchUpInside);
            keyButton1.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
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
            keyButton3.addTarget(self, action: "buttonHighlight:", forControlEvents: UIControlEvents.TouchUpInside);
            keyButton3.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
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
        sender.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
        var secondKeys = ["a", "e", "h", "i", "o", "m", "c", "u", "n"]
        var secondTags = [65, 69, 72, 73, 79, 77, 67, 85, 68]
        var i: Int = 0
        var j: Int = 1
        var final: String = ""
        var current = sender.titleLabel!.text!
        while (i != count(secondKeys)) {
                if i == 0 {
                    final = current + secondKeys[0]
                }
                if i == 1 {
                    final = current + secondKeys[1]
                }
                if i == 2 {
                    final = current + secondKeys[2]
                }
                if i == 3 {
                    final = current + secondKeys[3]
                }
                if i == 4 {
                    final = current + secondKeys[4]
                }
                if i == 5 {
                    final = current + secondKeys[5]
                }
                if i == 6 {
                    final = current + secondKeys[6]
                }
                if i == 7 {
                    final = current + secondKeys[7]
                }
                if i == 8 {
                    final = current + secondKeys[8]
                }
                if i == count(secondKeys) {
                   break
                }
                println(final)
                var buttons: [UIButton] = []
                for item in self.view.subviews as! [UIView] {
                    let button : UIButton = item as! UIButton
                    buttons.append(button)
                }
                if i == 0 {
                    var nextKey = buttons[0]
                    nextKey.setTitle(final, forState: UIControlState.Normal)
                    nextKey.titleLabel!.text = final
                    nextKey.tag = secondTags[i]
                }
                if i == 1 {
                var nextKey = buttons[1]
                nextKey.setTitle(final, forState: UIControlState.Normal)
                nextKey.titleLabel!.text = final
                nextKey.tag = secondTags[i]
                }
                if i == 2 {
                var nextKey = buttons[2]
                nextKey.setTitle(final, forState: UIControlState.Normal)
                nextKey.titleLabel!.text = final
                nextKey.tag = secondTags[i]
                }
                if i == 3 {
                var nextKey = buttons[3]
                nextKey.setTitle(final, forState: UIControlState.Normal)
                nextKey.titleLabel!.text = final
                nextKey.tag = secondTags[i]
                }
                if i == 4 {
                var nextKey = buttons[4]
                nextKey.setTitle(final, forState: UIControlState.Normal)
                nextKey.titleLabel!.text = final
                nextKey.tag = secondTags[i]
                }
                if i == 5 {
                var nextKey = buttons[5]
                nextKey.setTitle(final, forState: UIControlState.Normal)
                nextKey.titleLabel!.text = final
                nextKey.tag = secondTags[i]
                }
                if i == 6 {
                var nextKey = buttons[6]
                nextKey.setTitle(final, forState: UIControlState.Normal)
                nextKey.titleLabel!.text = final
                
                }
                if i == 7 {
                var nextKey = buttons[7]
                nextKey.setTitle(final, forState: UIControlState.Normal)
                nextKey.titleLabel!.text = final
                nextKey.tag = secondTags[i]
                }
                if i == 8 {
                var nextKey = buttons[8]
                nextKey.setTitle(final, forState: UIControlState.Normal)
                nextKey.titleLabel!.text = final
                nextKey.tag = secondTags[i]
                }
                i++
            }
    }
    override func buttonNormal(sender: UIButton!) {
        var btnsendtag:UIButton = sender
        sender.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
    }
    func secondaryFilter(sender: UIButton!) {
        if (firstTap >= 0) {
            for item in self.view.subviews as! [UIView] {
                var buttonColor:UIButton = item as! UIButton
            }
        }
    }
}
