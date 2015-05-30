//
//  ViewController.swift
//  keyboardTest
//
//  Created by Neetin Sharma on 3/11/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

var wordLabel = UITextField();
var firstTap : Int = 0
var popKeys: UIViewController = PagingViewController0_0()

class PagingViewController0: UIViewController, UITextFieldDelegate {
    @IBOutlet var deleteKey: UIButton!
    @IBOutlet var txtSearch : UITextField! = nil
    
    @IBOutlet var keyboardClose: UIButton!

    @IBAction func deleteKey(sender: UIButton) {
        if (wordLabel.text != "") {
            wordLabel.text = wordLabel.text.substringToIndex(wordLabel.text.endIndex.predecessor())
            contactsSearchController.searchBar.text! = contactsSearchController.searchBar.text!.substringToIndex(contactsSearchController.searchBar.text!.endIndex.predecessor())
            firstTap--
        }
    }

    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
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
        keyboardClose.addTarget(self, action: "backToInitialView:", forControlEvents: UIControlEvents.TouchDown)
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
    
    func backToInitialView(sender: UIButton!) {
        contactsSearchController.searchBar.text! = ""
        PagingViewController0_0().lookupController?.restart()
        dismissViewControllerAnimated(true, completion: nil)
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


