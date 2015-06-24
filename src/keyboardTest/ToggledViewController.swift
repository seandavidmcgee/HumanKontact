//
//  ToggledViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 4/6/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

class ToggledViewController: UIViewController, CAPSPageMenuDelegate {
    
    var searchpageMenu : CAPSPageMenu?
    var parentNavigationController : UINavigationController?
    let controller = KeyboardViewController()
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Browse Contacts"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 21.0)!]
        
        var menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        menuBtn.setImage(UIImage(named: "drawerMenu"), forState: UIControlState.Normal)
        menuBtn.setImage(UIImage(named: "drawerMenu"), forState: UIControlState.Highlighted)
        menuBtn.addTarget(self, action: Selector("toggleRightDrawer:"), forControlEvents:  UIControlEvents.TouchUpInside)
        var item = UIBarButtonItem(customView: menuBtn)
        self.navigationItem.rightBarButtonItem = item
        
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [FlatHKDark(), FlatHKLight()])
        
        var searchControllerArray : [UIViewController] = []
        
        var searchcontroller1 : TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
        searchcontroller1.parentNavigationController = self.navigationController
        searchcontroller1.title = "list"
        searchControllerArray.append(searchcontroller1)
        
        var searchcontroller2 : TestCollectionViewController = TestCollectionViewController(nibName: "TestCollectionViewController", bundle: nil)
        searchcontroller2.title = "grid"
        searchControllerArray.append(searchcontroller2)
        
        var searchcontroller3 : FavoritesTableViewController = FavoritesTableViewController(nibName: "TestTableViewController", bundle: nil)
        searchcontroller3.parentNavigationController = self.navigationController
        searchcontroller3.title = "favorites"
        searchControllerArray.append(searchcontroller3)
        
        var searchParameters: [String: AnyObject] = ["scrollMenuBackgroundColor": UIColor(red: 215/255, green: 20/255, blue: 55/255, alpha: 0.66),
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
        
        searchpageMenu = CAPSPageMenu(viewControllers: searchControllerArray, frame: CGRectMake(0, 0, view.frame.width, height), options: searchParameters)
        
        // Optional delegate
        searchpageMenu!.delegate = self
        
        self.view.addSubview(searchpageMenu!.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {}
    
    func toggleRightDrawer(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toggleRightDrawer(sender, animated: true)
    }
}