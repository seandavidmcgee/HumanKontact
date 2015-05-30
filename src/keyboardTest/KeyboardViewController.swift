//
//  KeyboardView.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/26/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {
    
    var lookupController : KannuuIndexController? = nil
    var entrySoFar : String? = nil
    var nameSearch = UITextField()
    var objects = [AnyObject]()
    var buttonsArray: Array<UIButton> = []
    var buttonXFirst: CGFloat = 128
    var buttonXSecond: CGFloat = 128
    var buttonXThird: CGFloat = 128
    var keyPresses: Int = 1
    
    func refreshData() {
        let abController = AddressBookController.sharedController()
        self.lookupController = abController.lookupController;
        if let lookupController = self.lookupController {
            self.objects = lookupController.options!
            self.entrySoFar = lookupController.entrySoFar
            self.nameSearch.text = self.entrySoFar
        } else {
            abController.askPermissionsWithCompletion({ (success : Bool) -> Void in
                if success == true {
                    self.lookupController = abController.lookupController
                    self.objects = self.lookupController!.options!
                    self.entrySoFar = self.lookupController!.entrySoFar
                    self.nameSearch.text = self.entrySoFar
                    dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                        self.view.reloadInputViews()
                        })
                }
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.populateKeys()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        var effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var vibrancy = UIVibrancyEffect(forBlurEffect: effect)
        var blurView = UIVisualEffectView(effect: effect)
        blurView.frame = view.frame
        self.view = blurView
        
        nameSearch = UITextField(frame: CGRectMake(10.0, 10.0, 238.0, 40.0))
        nameSearch.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        nameSearch.borderStyle = UITextBorderStyle.Line
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, wordLabel.bounds.height))
        nameSearch.leftView = paddingView
        nameSearch.leftViewMode = UITextFieldViewMode.Always
        
        self.view.addSubview(nameSearch)
        
        var dismissKeyboard = UIButton(frame: CGRect(x: self.view.frame.width - 48, y: 20, width: 30, height: 30))
        dismissKeyboard.setBackgroundImage(UIImage(named: "KeyboardReverse"), forState: UIControlState.Normal)
        dismissKeyboard.addTarget(self, action: "backToInitialView", forControlEvents: UIControlEvents.TouchDown)
        
        self.view.addSubview(dismissKeyboard)
        
        var deleteInput = UIButton(frame: CGRect(x: self.view.frame.width - 98, y: 23, width: 26, height: 13))
        deleteInput.setBackgroundImage(UIImage(named: "Delete"), forState: UIControlState.Normal)
        deleteInput.addTarget(self, action: "deleteSearchInput:", forControlEvents: UIControlEvents.TouchDown)
        
        self.view.addSubview(deleteInput)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToInitialView() {
        self.lookupController?.restart()
        self.refreshData()
        for index in 0..<objects.count {
            var keyInput = objects[index] as! String
            buttonsArray[index].setTitle("\(keyInput)", forState: UIControlState.Normal)
            buttonsArray[index].titleLabel!.text = "\(keyInput)"
            buttonsArray[index].hidden = false
        }
        self.view.hidden = true
        contactsSearchController.searchBar.text! = ""
        contactsSearchController.active = false
        nameSearch.text! = ""
        keyPresses == 1
    }
    
    func populateKeys() {
        for index in 0..<objects.count {
            if (index < 3) {
                let keyButton1 = UIButton(frame: CGRect(x: buttonXFirst, y: 60, width: 72, height: 52))
                buttonXFirst = buttonXFirst + 82
                
                keyButton1.layer.cornerRadius = 0
                keyButton1.layer.borderWidth = 1
                keyButton1.setTitleColor(UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ), forState: UIControlState.Normal)
                keyButton1.layer.borderColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ).CGColor;
                keyButton1.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
                keyButton1.setTitle("\(objects[index])", forState: UIControlState.Normal)
                keyButton1.setTitleColor(UIColor(white: 248/255, alpha: 0.5), forState: UIControlState.Highlighted)
                keyButton1.titleLabel!.text = "\(objects[index])"
                keyButton1.titleLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
                keyButton1.tag = index
                buttonsArray.append(keyButton1)
                
                keyButton1.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
                keyButton1.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpInside);
                
                self.view.addSubview(keyButton1)
            }
            
            if (index < 6 && index >= 3) {
                let keyButton2 = UIButton(frame: CGRect(x: buttonXSecond, y: 122, width: 72, height: 52))
                buttonXSecond = buttonXSecond + 82
                
                keyButton2.layer.cornerRadius = 0
                keyButton2.layer.borderWidth = 1
                keyButton2.setTitleColor(UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ), forState: UIControlState.Normal)
                keyButton2.layer.borderColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ).CGColor;
                keyButton2.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
                keyButton2.setTitle("\(objects[index])", forState: UIControlState.Normal)
                keyButton2.setTitleColor(UIColor(white: 248/255, alpha: 0.5), forState: UIControlState.Highlighted)
                keyButton2.titleLabel!.text = "\(objects[index])"
                keyButton2.titleLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
                keyButton2.tag = index
                buttonsArray.append(keyButton2)
                
                keyButton2.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
                keyButton2.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpInside);
                
                self.view.addSubview(keyButton2)
            }
            
            if (index < 9 && index >= 6) {
                let keyButton3 = UIButton(frame: CGRect(x: buttonXThird, y: 184, width: 72, height: 52))
                buttonXThird = buttonXThird + 82
                
                keyButton3.layer.cornerRadius = 0
                keyButton3.layer.borderWidth = 1
                keyButton3.setTitleColor(UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ), forState: UIControlState.Normal)
                keyButton3.layer.borderColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ).CGColor;
                keyButton3.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
                keyButton3.setTitle("\(objects[index])", forState: UIControlState.Normal)
                keyButton3.setTitleColor(UIColor(white: 248/255, alpha: 0.5), forState: UIControlState.Highlighted)
                keyButton3.titleLabel!.text = "\(objects[index])"
                keyButton3.titleLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
                keyButton3.tag = index
                buttonsArray.append(keyButton3)
                
                keyButton3.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
                keyButton3.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpInside);
                
                self.view.addSubview(keyButton3)
            }
        }
    }
    
    func keyPressed(sender: UIButton!) {
        sender.backgroundColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 )
        var nextOptions = self.lookupController!.selectOption(sender.tag)
        contactsSearchController.searchBar.text = sender.titleLabel!.text!
        nameSearch.text = sender.titleLabel!.text!
        var baseKey = sender.titleLabel!.text!
        self.refreshData()
        keyPresses++
        for index in 0..<objects.count {
            var keyInput = objects[index] as! String
            let combinedKeys = "\(baseKey)" + "\(keyInput)"
            buttonsArray[index].setTitle("\(combinedKeys)", forState: UIControlState.Normal)
            buttonsArray[index].titleLabel!.text = "\(combinedKeys)"
        }
        for key in objects.count..<buttonsArray.count {
            buttonsArray[key].hidden = true
        }
    }
    
    func deleteSearchInput(sender: UIButton!) {
        var baseKey : String
        nameSearch.text! = nameSearch.text.substringToIndex(nameSearch.text!.endIndex.predecessor())
        contactsSearchController.searchBar.text! = nameSearch.text!
        if (nameSearch.text != "" && contactsSearchController.searchBar.text != "") {
            keyPresses--
            baseKey = nameSearch.text!
            for index in 1..<keyPresses {
                self.lookupController?.back()
            }
            self.refreshData()
            for index in 0..<objects.count {
                var keyInput = objects[index] as! String
                let combinedKeys = "\(baseKey)" + "\(keyInput)"
                buttonsArray[index].setTitle("\(combinedKeys)", forState: UIControlState.Normal)
                buttonsArray[index].titleLabel!.text = "\(combinedKeys)"
                buttonsArray[index].hidden = false
            }
        }
        if (nameSearch.text == "" && contactsSearchController.searchBar.text == "") {
            for index in 0..<keyPresses {
                self.lookupController?.back()
            }
            self.refreshData()
            for index in 0..<objects.count {
                var keyInput = objects[index] as! String
                buttonsArray[index].setTitle("\(keyInput)", forState: UIControlState.Normal)
                buttonsArray[index].titleLabel!.text = "\(keyInput)"
                buttonsArray[index].hidden = false
            }
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            var baseKey : String = nameSearch.text!
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                if (keyPresses == 1) {
                    if (self.lookupController!.optionCount > 0) {
                        self.lookupController?.back()
                        self.refreshData()
                        for index in 0..<objects.count {
                            var keyInput = objects[index] as! String
                            buttonsArray[index].setTitle("\(keyInput)", forState: UIControlState.Normal)
                            buttonsArray[index].titleLabel!.text = "\(keyInput)"
                            buttonsArray[index].hidden = false
                        }
                    }
                }
                if (keyPresses > 1) {
                    if (self.lookupController!.moreOptions) {
                        self.lookupController?.back()
                        self.refreshData()
                        for index in 0..<objects.count {
                            var keyInput = objects[index] as! String
                            let combinedKeys = "\(baseKey)" + "\(keyInput)"
                            buttonsArray[index].setTitle("\(combinedKeys)", forState: UIControlState.Normal)
                            buttonsArray[index].titleLabel!.text = "\(combinedKeys)"
                            buttonsArray[index].hidden = false
                        }
                        for key in objects.count..<buttonsArray.count {
                            buttonsArray[key].hidden = true
                        }
                    }
                    else {
                        println("No more options")
                        break
                    }
                }
                println("Swiped right")
            case UISwipeGestureRecognizerDirection.Left:
                if (self.lookupController!.moreOptions) {
                self.lookupController?.more()
                self.refreshData()
                if (keyPresses == 1) {
                    for index in 0..<objects.count {
                        var keyInput = objects[index] as! String
                        buttonsArray[index].setTitle("\(keyInput)", forState: UIControlState.Normal)
                        buttonsArray[index].titleLabel!.text = "\(keyInput)"
                        buttonsArray[index].hidden = false
                    }
                    for key in objects.count..<buttonsArray.count {
                        buttonsArray[key].hidden = true
                    }
                }
                if (keyPresses > 1) {
                    for index in 0..<objects.count {
                        var keyInput = objects[index] as! String
                        let combinedKeys = "\(baseKey)" + "\(keyInput)"
                        buttonsArray[index].setTitle("\(combinedKeys)", forState: UIControlState.Normal)
                        buttonsArray[index].titleLabel!.text = "\(combinedKeys)"
                        buttonsArray[index].hidden = false
                    }
                    for key in objects.count..<buttonsArray.count {
                        buttonsArray[key].hidden = true
                    }
                }
                println("Swiped left")
                }
            default:
                break
            }
        }
    }
    
    func buttonNormal(sender: UIButton!) {
        sender.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
    }
}
