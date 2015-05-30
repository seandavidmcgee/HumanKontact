//
//  PagingViewController2.swift
//  keyboardTest
//
//  Created by Sean McGee on 4/6/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

class PagingViewController2:  UIViewController, UITextFieldDelegate {

    var objects = [AnyObject]()
    var buttonXFirst: CGFloat = 0
    var buttonXSecond: CGFloat = 0
    var buttonXThird: CGFloat = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.refreshData()
        for index in 0..<objects.count {
            if (index < 3) {
                let keyButton1 = UIButton(frame: CGRect(x: buttonXFirst, y: 10, width: 52, height: 52))
                buttonXFirst = buttonXFirst + 62
                
                keyButton1.layer.cornerRadius = 0
                keyButton1.layer.borderWidth = 1
                keyButton1.setTitleColor(UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ), forState: UIControlState.Normal)
                keyButton1.layer.borderColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ).CGColor;
                keyButton1.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
                keyButton1.setTitle("\(objects[index])", forState: UIControlState.Normal)
                keyButton1.setTitleColor(UIColor(white: 248/255, alpha: 0.5), forState: UIControlState.Highlighted)
                keyButton1.titleLabel!.text = "\(objects[index])"
                
                keyButton1.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
                keyButton1.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpInside);
                
                self.view.addSubview(keyButton1)
            }
            if (index < 6 && index >= 3) {
                let keyButton2 = UIButton(frame: CGRect(x: buttonXSecond, y: 72, width: 52, height: 52))
                buttonXSecond = buttonXSecond + 62
                keyButton2.layer.cornerRadius = 0
                keyButton2.layer.borderWidth = 1
                keyButton2.setTitleColor(UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ), forState: UIControlState.Normal)
                keyButton2.layer.borderColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ).CGColor;
                keyButton2.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
                keyButton2.setTitle("\(objects[index])", forState: UIControlState.Normal)
                keyButton2.titleLabel!.text = "\(objects[index])"
                
                keyButton2.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
                keyButton2.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpInside);
                
                self.view.addSubview(keyButton2)
            }
            if (index < 9 && index >= 6) {
                let keyButton3 = UIButton(frame: CGRect(x: buttonXThird, y: 134, width: 52, height: 52))
                buttonXThird = buttonXThird + 62
                keyButton3.layer.cornerRadius = 0
                keyButton3.layer.borderWidth = 1
                keyButton3.setTitleColor(UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ), forState: UIControlState.Normal)
                keyButton3.layer.borderColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 ).CGColor;
                keyButton3.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
                keyButton3.setTitle("\(objects[index])", forState: UIControlState.Normal)
                keyButton3.titleLabel!.text = "\(objects[index])"
                
                keyButton3.addTarget(self, action: "keyPressed:", forControlEvents: UIControlEvents.TouchDown);
                keyButton3.addTarget(self, action: "buttonNormal:", forControlEvents: UIControlEvents.TouchUpInside);
                
                self.view.addSubview(keyButton3)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParentViewController() {
            self.lookupController?.back()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var lookupController : KannuuIndexController? = nil
    var entrySoFar : String? = nil
    
    private func refreshData () {
        let abController = AddressBookController.sharedController()
        self.lookupController = abController.lookupController;
        if let lookupController = self.lookupController {
            var more = self.lookupController?.more()
            self.objects = lookupController.options!
            self.entrySoFar = lookupController.entrySoFar
            wordLabel.text = self.entrySoFar;
            self.view.reloadInputViews()
        } else {
            abController.askPermissionsWithCompletion({ (success : Bool) -> Void in
                if success == true {
                    self.lookupController = abController.lookupController
                    self.objects = self.lookupController!.options!
                    self.entrySoFar = self.lookupController!.entrySoFar
                    wordLabel.text = self.entrySoFar;
                    dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                        self.view.reloadInputViews()
                        })
                }
            })
        }
    }
    
    func keyPressed(sender: UIButton!) {
        sender.backgroundColor = UIColor(red: 0.004, green: 0.078, blue: 0.216, alpha: 1.000 )
        wordLabel.text = sender.titleLabel?.text
    }
    
    func buttonNormal(sender: UIButton!) {
        sender.backgroundColor = UIColor(white: 248/255, alpha: 0.5)
    }
}