//
//  ViewController.swift
//  keyboardTest
//
//  Created by Neetin Sharma on 3/11/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

var wordLabel = UITextField();

class PagingViewController0: UIViewController, UITextFieldDelegate {
    @IBOutlet var deleteKey: UIButton!
    @IBOutlet var txtSearch : UITextField! = nil
    @IBOutlet var keyboardButtonClose: UIButton!
    
    @IBAction func deleteKey(sender: UIButton) {
        if (wordLabel.text != "") {
            wordLabel.text = wordLabel.text.substringToIndex(wordLabel.text.endIndex.predecessor())
        }
    }
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel = UITextField(frame: CGRectMake(10.0, 399.0, 238.0, 40.0))
        wordLabel.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        wordLabel.borderStyle = UITextBorderStyle.Line
        self.view.addSubview(wordLabel)
        
        var controllerArray : [UIViewController] = []
        
        var controller1 : UIViewController = PagingViewController0_0()
        controller1.view.backgroundColor = UIColor.clearColor()
        controller1.title = ""
        controllerArray.append(controller1)
        var controller2 : UIViewController = PagingViewController1()
        controller2.view.backgroundColor = UIColor.clearColor()
        controller2.title = ""
        controllerArray.append(controller2)
        var controller3 : UIViewController = PagingViewController2()
        controller3.view.backgroundColor = UIColor.clearColor()
        controller3.title = ""
        controllerArray.append(controller3)
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, wordLabel.bounds.height))
        wordLabel.leftView = paddingView
        wordLabel.leftViewMode = UITextFieldViewMode.Always
        
        txtSearch.delegate = self
        
        // Customize menu (Optional)
        var parameters: [String: AnyObject] = ["scrollMenuBackgroundColor": UIColor.clearColor(),
            "viewBackgroundColor": UIColor.clearColor(),
            "selectionIndicatorColor": UIColor.orangeColor(),
            "addBottomMenuHairline": false,
            "menuItemFont": UIFont(name: "HelveticaNeue", size: 35.0)!,
            "menuHeight": 0.0,
            "selectionIndicatorHeight": 0.0,
            "selectedMenuItemLabelColor": UIColor.orangeColor()]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(self.view.frame.width - 190.0, self.view.frame.height - 216.0, 186.0, 216.0), options: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches as Set<NSObject>, withEvent: event)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }
    
    var firstTap : Int = 0
    func keyPressed(sender: UIButton!) {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        sender.backgroundColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 )
        
        println("ascii key : \(sender.tag)")
        
        if (firstTap > 0) {
            switch sender.tag {
            case 8:
                var temp = wordLabel.text!
                if count(temp) > 1 {
                    let chunks = Array(temp)
                    var final = ""
                    for i in 0 ..< chunks.count {
                        final = final + String(chunks[i])
                        if i == count(chunks) - 2 {
                            break
                        }
                    }
                    wordLabel.text =  final
                }
                else {
                    wordLabel.text = ""
                }
            case 32:
                wordLabel.text =  wordLabel.text! + " "
            case 65:
                wordLabel.text =  wordLabel.text! + "a"
            case 66:
                wordLabel.text =  wordLabel.text! + "b"
            case 67:
                wordLabel.text =  wordLabel.text! + "c"
            case 68:
                wordLabel.text =  wordLabel.text! + "d"
            case 69:
                wordLabel.text =  wordLabel.text! + "e"
            case 70:
                wordLabel.text =  wordLabel.text! + "f"
            case 71:
                wordLabel.text =  wordLabel.text! + "g"
            case 72:
                wordLabel.text =  wordLabel.text! + "h"
            case 73:
                wordLabel.text =  wordLabel.text! + "i"
            case 74:
                wordLabel.text =  wordLabel.text! + "j"
            case 75:
                wordLabel.text =  wordLabel.text! + "k"
            case 76:
                wordLabel.text =  wordLabel.text! + "l"
            case 77:
                wordLabel.text =  wordLabel.text! + "m"
            case 78:
                wordLabel.text =  wordLabel.text! + "n"
            case 79:
                wordLabel.text =  wordLabel.text! + "o"
            case 80:
                wordLabel.text =  wordLabel.text! + "p"
            case 81:
                wordLabel.text =  wordLabel.text! + "q"
            case 82:
                wordLabel.text =  wordLabel.text! + "r"
            case 83:
                wordLabel.text =  wordLabel.text! + "s"
            case 84:
                wordLabel.text =  wordLabel.text! + "t"
            case 85:
                wordLabel.text =  wordLabel.text! + "u"
            case 86:
                wordLabel.text =  wordLabel.text! + "v"
            case 87:
                wordLabel.text =  wordLabel.text! + "w"
            case 88:
                wordLabel.text =  wordLabel.text! + "x"
            case 89:
                wordLabel.text =  wordLabel.text! + "y"
            case 90:
                wordLabel.text =  wordLabel.text! + "z"
                
            default:
                break
            }
            firstTap++
        }
        else {
            switch sender.tag {
            case 8:
                var temp = wordLabel.text!
                if count(temp) > 1 {
                    let chunks = Array(temp)
                    var final = ""
                    for i in 0 ..< chunks.count {
                        final = final + String(chunks[i])
                        if i == count(chunks) - 2 {
                            break
                        }
                    }
                    wordLabel.text =  final
                }
                else {
                    wordLabel.text = ""
                }

        case 32:
            wordLabel.text =  wordLabel.text! + " "
        case 65:
            wordLabel.text =  wordLabel.text! + "A"
        case 66:
            wordLabel.text =  wordLabel.text! + "B"
        case 67:
            wordLabel.text =  wordLabel.text! + "C"
        case 68:
            wordLabel.text =  wordLabel.text! + "D"
        case 69:
            wordLabel.text =  wordLabel.text! + "E"
        case 70:
            wordLabel.text =  wordLabel.text! + "F"
        case 71:
            wordLabel.text =  wordLabel.text! + "G"
        case 72:
            wordLabel.text =  wordLabel.text! + "H"
        case 73:
            wordLabel.text =  wordLabel.text! + "I"
        case 74:
            wordLabel.text =  wordLabel.text! + "J"
        case 75:
            wordLabel.text =  wordLabel.text! + "K"
        case 76:
            wordLabel.text =  wordLabel.text! + "L"
        case 77:
            wordLabel.text =  wordLabel.text! + "M"
        case 78:
            wordLabel.text =  wordLabel.text! + "N"
        case 79:
            wordLabel.text =  wordLabel.text! + "O"
        case 80:
            wordLabel.text =  wordLabel.text! + "P"
        case 81:
            wordLabel.text =  wordLabel.text! + "Q"
        case 82:
            wordLabel.text =  wordLabel.text! + "R"
        case 83:
            wordLabel.text =  wordLabel.text! + "S"
        case 84:
            wordLabel.text =  wordLabel.text! + "T"
        case 85:
            wordLabel.text =  wordLabel.text! + "U"
        case 86:
            wordLabel.text =  wordLabel.text! + "V"
        case 87:
            wordLabel.text =  wordLabel.text! + "W"
        case 88:
            wordLabel.text =  wordLabel.text! + "X"
        case 89:
            wordLabel.text =  wordLabel.text! + "Y"
        case 90:
            wordLabel.text =  wordLabel.text! + "Z"

            default:
                break
            }
            firstTap++
        }
    }
    
    func buttonHighlight(sender: UIButton!) {
        var btnsendtag:UIButton = sender
        sender.backgroundColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 )
    }
    func buttonNormal(sender: UIButton!) {
        var btnsendtag:UIButton = sender
        sender.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
    }
}


