//
//  RecentsViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/11/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

class RecentsViewController: UIViewController {
    
    var parentNavigationController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Recents"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 21.0)!]
        
        var menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        menuBtn.setImage(UIImage(named: "drawerMenu"), forState: UIControlState.Normal)
        menuBtn.setImage(UIImage(named: "drawerMenu"), forState: UIControlState.Highlighted)
        menuBtn.addTarget(self, action: Selector("toggleRightDrawer:"), forControlEvents:  UIControlEvents.TouchUpInside)
        var item = UIBarButtonItem(customView: menuBtn)
        self.navigationItem.rightBarButtonItem = item
        
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [FlatHKDark(), FlatHKLight()])
    }
    
    override func didReceiveMemoryWarning() {}
    
    func toggleRightDrawer(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toggleRightDrawer(sender, animated: true)
    }
}