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
    
    override func viewWillAppear(animated: Bool) {
        self.addButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search Contacts"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 21.0)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [FlatHKDark(), FlatHKLight()])
        
        var searchControllerArray : [UIViewController] = []
        
        var searchcontroller1 : TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
        searchcontroller1.parentNavigationController = self.navigationController
        searchcontroller1.title = "favorites"
        searchControllerArray.append(searchcontroller1)
        
        var searchcontroller2 : TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
        searchcontroller2.parentNavigationController = self.navigationController
        searchcontroller2.title = "list"
        searchControllerArray.append(searchcontroller2)
        
        var searchcontroller3 : TestCollectionViewController = TestCollectionViewController(nibName: "TestCollectionViewController", bundle: nil)
        searchcontroller3.title = "grid"
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    
        if (segue.identifier == "goToViewController") {
            let vc = segue.destinationViewController as! PagingViewController0
        }
    }
    
    override func didReceiveMemoryWarning() {}
    
    func addButton() {
        let image = UIImage(named: "icon-key-shadow") as UIImage?
        let keyboardButton = UIButton()
        keyboardButton.frame = CGRectMake(self.view.frame.width - 48, self.view.frame.height - 48, 45, 45);
        keyboardButton.layer.backgroundColor = UIColor(red: 176/255, green: 182/255, blue: 187/255, alpha: 0.8).CGColor;
        keyboardButton.setImage(image, forState: .Normal)
        keyboardButton.layer.cornerRadius = CGRectGetWidth(keyboardButton.frame)/2.0;
        keyboardButton.layer.shadowColor = UIColor.blackColor().CGColor;
        keyboardButton.layer.shadowOffset = CGSizeMake(2, 2);
        keyboardButton.layer.shadowOpacity = 1;
        keyboardButton.layer.shadowRadius = 1.0;
        keyboardButton.addTarget(self, action: "keyboardButtonClicked:", forControlEvents: UIControlEvents.TouchDown);
        self.view.addSubview(keyboardButton)
    }
    
    func keyboardButtonClicked(sender: UIButton!) {
        performSegueWithIdentifier("goToViewController", sender: sender)
    }
    @IBAction func toggleRightDrawer(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toggleRightDrawer(sender, animated: true)
    }
}