//
//  BrowseViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/11/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit


class BrowseViewController: UIViewController, CAPSPageMenuDelegate {
    
    var browsepageMenu : CAPSPageMenu?
    var parentNavigationController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Browse Contacts"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 21.0)!]
        
        var menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        menuBtn.setImage(UIImage(named: "drawerMenu"), forState: UIControlState.Normal)
        menuBtn.setImage(UIImage(named: "drawerMenu"), forState: UIControlState.Highlighted)
        menuBtn.addTarget(self, action: Selector("toggleRightDrawer:"), forControlEvents:  UIControlEvents.TouchUpInside)
        var item = UIBarButtonItem(customView: menuBtn)
        self.navigationItem.rightBarButtonItem = item
        
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [FlatHKDark(), FlatHKLight()])
        
        var browseControllerArray : [UIViewController] = []
        
        var browsecontroller1 : TestCollectionViewController = TestCollectionViewController(nibName: "TestCollectionViewController", bundle: nil)
        browsecontroller1.title = "grid"
        browseControllerArray.append(browsecontroller1)
        
        var browsecontroller2 : TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
        browsecontroller2.title = "list"
        browseControllerArray.append(browsecontroller2)
        
        var browseParameters: [String: AnyObject] = ["scrollMenuBackgroundColor": UIColor(red: 31/255, green: 165/255, blue: 251/255, alpha: 0.66),
            "viewBackgroundColor": UIColor.clearColor(),
            "selectionIndicatorColor": UIColor.whiteColor(),
            "addBottomMenuHairline": false,
            "menuItemFont": UIFont(name: "AvenirNext-Regular", size: 17.0)!,
            "menuMargin": 20.0,
            "menuHeight": 30.0,
            "selectionIndicatorHeight": 0.0,
            "menuItemWidthBasedOnTitleTextWidth": true,
            "selectedMenuItemLabelColor": UIColor.whiteColor()]
        var height = view.frame.height;
        
        browsepageMenu = CAPSPageMenu(viewControllers: browseControllerArray, frame: CGRectMake(0, 0, view.frame.width, height), options: browseParameters)
        
        // Optional delegate
        browsepageMenu!.delegate = self
        
        self.view.addSubview(browsepageMenu!.view)
    }
    
    override func didReceiveMemoryWarning() {}
    
    func toggleRightDrawer(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toggleRightDrawer(sender, animated: true)
    }
}
