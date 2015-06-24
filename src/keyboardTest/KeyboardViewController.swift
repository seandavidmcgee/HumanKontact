//
//  KeyboardView.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/26/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

var entrySoFar : String? = nil
var nameSearch = UITextField()

class KeyboardViewController: UIViewController, UITextFieldDelegate {
    
    var buttonsArray: Array<UIButton> = []
    var buttonsBlurArray = [AnyObject]()
    var buttonXFirst: CGFloat = 250
    var buttonXSecond: CGFloat = 250
    var buttonXThird: CGFloat = 250
    var keyPresses: Int = 1
    var deleteInput: UIButton!
    var moreOptionsForward: UIButton! = UIButton()
    var moreOptionsBack: UIButton! = UIButton()
    var altKeyboard: UIButton! = UIButton()
    var textFieldInsideSearchBar = contactsSearchController.searchBar.valueForKey("searchField") as? UITextField
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createKeyboard()
        dismissKeyboard()
        deleteBtn()
        navKeys()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshData() {
        dispatch_async(dispatch_get_main_queue()) {
            if var indexController = lookupController {
                myResults.removeAll(keepCapacity: false)
                objectKeys.removeAll(keepCapacity: false)
                objectKeys = indexController.options!
                var selections = indexController.branchSelecions!
                myResults += selections
                entrySoFar = indexController.entrySoFar!
                nameSearch.text = entrySoFar
                contactsSearchController.searchBar.text = entrySoFar
            }
        }
    }
    
    func backToInitialView() {
        self.view.hidden = true
        contactsSearchController.searchBar.text! = ""
        contactsSearchController.active = false
        nameSearch.text! = ""
        keyPresses == 1
        lookupController?.restart()
        self.refreshData()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("singleReset"), userInfo: nil, repeats: false)
    }
    
    func createKeyboard() {
        self.view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        var effect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var vibrancy = UIVibrancyEffect(forBlurEffect: effect)
        var blurView = UIVisualEffectView(effect: effect)
        blurView.frame = view.frame
        self.view = blurView
        nameSearch = UITextField(frame: CGRectMake(10.0, 10.0, self.view.frame.width - 122, 40.0))
        nameSearch.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        nameSearch.borderStyle = UITextBorderStyle.None
        nameSearch.textColor = UIColor(white: 1.0, alpha: 1.0)
        nameSearch.layer.masksToBounds = true
        nameSearch.layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).CGColor
        nameSearch.layer.shadowOpacity = 1.0
        nameSearch.layer.shadowRadius = 0
        nameSearch.layer.shadowOffset = CGSizeMake(0, 1.5)
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, wordLabel.bounds.height))
        nameSearch.leftView = paddingView
        nameSearch.leftViewMode = UITextFieldViewMode.Always
        nameSearch.enabled = false
        
        self.view.addSubview(nameSearch)
        
        altKeyboard.frame = CGRect(x: 0, y: 237, width: 50, height: 50)
        altKeyboard.setImage(UIImage(named: "keyAlt"), forState: UIControlState.Normal)
        altKeyboard.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10)
        altKeyboard.addTarget(self, action: "useNormalKeyboard", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(altKeyboard)
    }
    
    func dismissKeyboard() {
        var dismissKeyboard = UIButton(frame: CGRect(x: nameSearch.frame.width + 75, y: 20, width: 30, height: 30))
        dismissKeyboard.setImage(UIImage(named: "KeyboardReverse"), forState: UIControlState.Normal)
        dismissKeyboard.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10)
        dismissKeyboard.addTarget(self, action: "backToInitialView", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(dismissKeyboard)
    }
    
    func useNormalKeyboard() {
        self.view.hidden = true
        contactsSearchController.active = false
        self.view.window?.rootViewController!.presentViewController(normalSearchController, animated: true, completion: nil)
        normalSearchController.active = true
    }
    
    func deleteBtn() {
        deleteInput = UIButton(frame: CGRect(x: nameSearch.frame.width + 30, y: 18, width: 26, height: 26))
        deleteInput.setImage(UIImage(named: "Delete"), forState: UIControlState.Disabled)
        deleteInput.setImage(UIImage(named: "Delete"), forState: UIControlState.Normal)
        deleteInput.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10)
        deleteInput.enabled = false
        deleteInput.addTarget(self, action: "deleteSearchInput:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(deleteInput)
    }
    
    func populateKeys() {
        for index in 0..<objectKeys.count {
            if (index < 3) {
                var keyButton1 = UIButton(frame: CGRect(x: self.view.frame.width - buttonXFirst, y: 65, width: 72, height: 52))
                buttonXFirst = buttonXFirst - 82
                
                keyButton1.layer.cornerRadius = keyButton1.frame.width / 6.0
                keyButton1.setTitleColor(UIColor(white: 1.0, alpha: 1.000 ), forState: UIControlState.Normal)
                keyButton1.backgroundColor = UIColor.clearColor()
                keyButton1.setTitle("\(objectKeys[index])", forState: UIControlState.Normal)
                keyButton1.setTitleColor(UIColor(white: 0.0, alpha: 1.000 ), forState: UIControlState.Highlighted)
                keyButton1.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
                keyButton1.titleLabel!.text = "\(objectKeys[index])"
                keyButton1.titleLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
                keyButton1.layer.masksToBounds = false
                keyButton1.layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).CGColor
                keyButton1.layer.shadowOpacity = 0.7
                keyButton1.layer.shadowRadius = 0
                keyButton1.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                keyButton1.tag = index
                let blur = UIBlurEffect(style: UIBlurEffectStyle.Light)
                var vibrancy = UIVibrancyEffect(forBlurEffect: blur)
                var blurView = UIVisualEffectView(effect: blur)
                blurView.frame = keyButton1.frame
                blurView.layer.cornerRadius = keyButton1.frame.width / 6.0
                blurView.clipsToBounds = true
                buttonsArray.append(keyButton1)
                buttonsBlurArray.append(blurView)
                
                keyButton1.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
                keyButton1.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpInside);
                
                self.view.addSubview(blurView)
                self.view.addSubview(keyButton1)
            }
            
            if (index < 6 && index >= 3) {
                var keyButton2 = UIButton(frame: CGRect(x: self.view.frame.width - buttonXSecond, y: 127, width: 72, height: 52))
                buttonXSecond = buttonXSecond - 82
                
                keyButton2.layer.cornerRadius = keyButton2.frame.width / 6.0
                keyButton2.setTitleColor(UIColor(white: 1.0, alpha: 1.000 ), forState: UIControlState.Normal)
                keyButton2.backgroundColor = UIColor.clearColor()
                keyButton2.setTitle("\(objectKeys[index])", forState: UIControlState.Normal)
                keyButton2.setTitleColor(UIColor(white: 0.0, alpha: 1.000 ), forState: UIControlState.Highlighted)
                keyButton2.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
                keyButton2.titleLabel!.text = "\(objectKeys[index])"
                keyButton2.titleLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
                keyButton2.layer.masksToBounds = false
                keyButton2.layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).CGColor
                keyButton2.layer.shadowOpacity = 0.7
                keyButton2.layer.shadowRadius = 0
                keyButton2.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                keyButton2.tag = index
                let blur = UIBlurEffect(style: UIBlurEffectStyle.Light)
                var vibrancy = UIVibrancyEffect(forBlurEffect: blur)
                var blurView = UIVisualEffectView(effect: blur)
                blurView.frame = keyButton2.frame
                blurView.layer.cornerRadius = keyButton2.frame.width / 6.0
                blurView.clipsToBounds = true
                buttonsArray.append(keyButton2)
                buttonsBlurArray.append(blurView)
                
                keyButton2.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
                keyButton2.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpInside);
                
                self.view.addSubview(blurView)
                self.view.addSubview(keyButton2)
            }
            
            if (index < 9 && index >= 6) {
                var keyButton3 = UIButton(frame: CGRect(x: self.view.frame.width - buttonXThird, y: 189, width: 72, height: 52))
                buttonXThird = buttonXThird - 82
                
                keyButton3.layer.cornerRadius = keyButton3.frame.width / 6.0
                keyButton3.setTitleColor(UIColor(white: 1.0, alpha: 1.000 ), forState: UIControlState.Normal)
                keyButton3.backgroundColor = UIColor.clearColor()
                keyButton3.setTitle("\(objectKeys[index])", forState: UIControlState.Normal)
                keyButton3.setTitleColor(UIColor(white: 0.0, alpha: 1.000 ), forState: UIControlState.Highlighted)
                keyButton3.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
                keyButton3.titleLabel!.text = "\(objectKeys[index])"
                keyButton3.titleLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
                keyButton3.layer.masksToBounds = false
                keyButton3.layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).CGColor
                keyButton3.layer.shadowOpacity = 0.7
                keyButton3.layer.shadowRadius = 0
                keyButton3.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                keyButton3.tag = index
                let blur = UIBlurEffect(style: UIBlurEffectStyle.Light)
                var vibrancy = UIVibrancyEffect(forBlurEffect: blur)
                var blurView = UIVisualEffectView(effect: blur)
                blurView.frame = keyButton3.frame
                blurView.layer.cornerRadius = keyButton3.frame.width / 6.0
                blurView.clipsToBounds = true
                buttonsArray.append(keyButton3)
                buttonsBlurArray.append(blurView)
                
                keyButton3.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
                keyButton3.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpInside);
                
                self.view.addSubview(blurView)
                self.view.addSubview(keyButton3)
            }
        }
    }
    
    func navKeys() {
        moreOptionsBack.frame = CGRect(x: self.view.frame.width - 250, y: 248, width: 26, height: 26)
        moreOptionsBack.setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        moreOptionsBack.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10)
        moreOptionsBack.tag = 998
        moreOptionsBack.hidden = true
        moreOptionsBack.addTarget(self, action: "respondToMore:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(moreOptionsBack)
        
        moreOptionsForward.frame = CGRect(x: self.view.frame.width - 40, y: 248, width: 26, height: 26)
        moreOptionsForward.setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        moreOptionsForward.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / 180.0)
        moreOptionsForward.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10)
        moreOptionsForward.tag = 999
        moreOptionsForward.addTarget(self, action: "respondToMore:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(moreOptionsForward)
    }
    
    func keyPressed(sender: UIButton!) {
        sender.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        var nextOptions = lookupController?.selectOption(sender.tag)
        self.refreshData()
        keyPresses++
    }
    
    func deleteSearchInput(sender: UIButton!) {
        keyPresses--
        if (keyPresses > 1) {
            lookupController?.back()
            self.refreshData()
            if (!lookupController!.atTop) {
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("combinedReset"), userInfo: nil, repeats: false)
            }
        }
        else {
            lookupController?.back()
            self.refreshData()
            deleteInput.enabled = false
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("singleReset"), userInfo: nil, repeats: false)
        }
    }
    
    func respondToMore(sender: UIButton!) {
        var baseKey : String = nameSearch.text!
        if (sender.tag == 998) {
            if (keyPresses == 1) {
                if (lookupController!.optionCount > 0) {
                    lookupController?.back()
                    objectKeys = lookupController!.options!
                    for index in 0..<objectKeys.count {
                        var keyInput = objectKeys[index] as! String
                        buttonsArray[index].setTitle("\(keyInput)", forState: UIControlState.Normal)
                        buttonsArray[index].titleLabel!.text = "\(keyInput)"
                        buttonsArray[index].hidden = false
                        buttonsBlurArray[index].layer.hidden = false
                    }
                }
            }
            if (keyPresses > 1) {
                if (lookupController!.moreOptions) {
                    lookupController?.back()
                    objectKeys = lookupController!.options!
                    for index in 0..<objectKeys.count {
                        var keyInput = objectKeys[index] as! String
                        let combinedKeys = "\(baseKey)" + "\(keyInput)"
                        buttonsArray[index].setTitle("\(combinedKeys)", forState: UIControlState.Normal)
                        buttonsArray[index].titleLabel!.text = "\(combinedKeys)"
                        buttonsArray[index].hidden = false
                        buttonsBlurArray[index].layer.hidden = false
                    }
                    for key in objectKeys.count..<buttonsArray.count {
                        buttonsArray[key].hidden = true
                        buttonsBlurArray[key].layer.hidden = true
                    }
                }
                else {
                    println("No more options")
                    return
                }
            }
            if (lookupController!.moreOptions) {
                if (lookupController!.optionCount == 9) {
                    moreOptionsForward.hidden = false
                    moreOptionsBack.hidden = false
                    
                    if (lookupController?.atTop == true) {
                        moreOptionsBack.hidden = true
                    }
                }
                else {
                    moreOptionsBack.hidden = true
                }
            }
        println("More options to right")
        }
        if (sender.tag == 999) {
            lookupController?.more()
            objectKeys = lookupController!.options!
            moreOptionsBack.hidden = false
            
            if (!lookupController!.moreOptions) {
                moreOptionsForward.hidden = true
            }
            if (keyPresses == 1) {
                for index in 0..<objectKeys.count {
                    var keyInput = objectKeys[index] as! String
                    buttonsArray[index].setTitle("\(keyInput)", forState: UIControlState.Normal)
                    buttonsArray[index].titleLabel!.text = "\(keyInput)"
                    buttonsArray[index].hidden = false
                    buttonsBlurArray[index].layer.hidden = false
                }
                for key in objectKeys.count..<buttonsArray.count {
                    buttonsArray[key].hidden = true
                    buttonsBlurArray[key].layer.hidden = true
                }
            }
            if (keyPresses > 1) {
                for index in 0..<objectKeys.count {
                    var keyInput = objectKeys[index] as! String
                    let combinedKeys = "\(baseKey)" + "\(keyInput)"
                    buttonsArray[index].setTitle("\(combinedKeys)", forState: UIControlState.Normal)
                    buttonsArray[index].titleLabel!.text = "\(combinedKeys)"
                    buttonsArray[index].hidden = false
                    buttonsBlurArray[index].layer.hidden = false
                }
                for key in objectKeys.count..<buttonsArray.count {
                    buttonsArray[key].hidden = true
                    buttonsBlurArray[key].layer.hidden = true
                }
            }
        }
    }
    
    func buttonNormal(sender: UIButton!) {
        sender.backgroundColor = UIColor.clearColor()
        var baseKey = sender.titleLabel!.text!
        for index in 0..<objectKeys.count {
            var keyInput = objectKeys[index] as! String
            let combinedKeys = "\(baseKey)" + "\(keyInput)"
            self.buttonsArray[index].setTitle("\(combinedKeys)", forState: UIControlState.Normal)
            self.buttonsArray[index].titleLabel!.text = "\(combinedKeys)"
            self.buttonsBlurArray[index].layer.hidden = false
        }
        for key in objectKeys.count..<self.buttonsArray.count {
            self.buttonsArray[key].hidden = true
            self.buttonsBlurArray[key].layer.hidden = true
        }
        
        deleteInput.enabled = true
    }
    
    func combinedReset() {
        var base = nameSearch.text
        for index in 0..<objectKeys.count {
            var keyInput = objectKeys[index] as! String
            let combinedKeys = "\(base)" + "\(keyInput)"
            buttonsArray[index].setTitle("\(combinedKeys)", forState: UIControlState.Normal)
            buttonsArray[index].titleLabel!.text = "\(combinedKeys)"
            buttonsArray[index].hidden = false
            buttonsBlurArray[index].layer.hidden = false
        }
    }
    
    func singleReset() {
        for index in 0..<objectKeys.count {
            var keyInput = objectKeys[index] as! String
            buttonsArray[index].setTitle("\(keyInput)", forState: UIControlState.Normal)
            buttonsArray[index].titleLabel!.text = "\(keyInput)"
            buttonsArray[index].hidden = false
            buttonsBlurArray[index].layer.hidden = false
        }
    }
}
