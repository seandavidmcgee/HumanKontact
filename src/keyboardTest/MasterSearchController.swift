//
//  MasterSearchController.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/30/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit
import Foundation
import AddressBook
import AddressBookUI

var parentSearchNavigationController : UINavigationController?
var contactsSearchController = UISearchController()
var normalSearchController = UISearchController()
let controller = KeyboardViewController()
var recentPeople = [AnyObject]()
var favPeople = [AnyObject]()
var keyboardOpen : Int = 0

class MasterSearchController: UIViewController, ABNewPersonViewControllerDelegate {
    var searchpageMenu : CAPSPageMenu?
    var parentNavigationController : UINavigationController?
    
    let listResults = FavoritesViewController()
    let gridResults = GridViewController()
    let recentResults = RecentsSubViewController()
    let favResults = AddedFavsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parentSearchNavigationController = self.navigationController
        self.addPagingViews()
        contactsSearchController = ({
            // Create the search results view controller and use it for the UISearchController.
            let searchController = UISearchController(searchResultsController: nil)
            let textFieldInsideSearchBar = searchController.searchBar.valueForKey("searchField") as? UITextField
            // Create the search controller and make it perform the results updating.
            searchController.searchResultsUpdater = self.listResults
            searchController.searchBar.barStyle = .BlackTranslucent
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.tintColor = UIColor.whiteColor()
            searchController.searchBar.sizeToFit()
            
            textFieldInsideSearchBar?.textColor = UIColor.whiteColor()
            textFieldInsideSearchBar?.delegate = self.listResults
            
            searchController.searchBar.hidden = true
            return searchController
        })()
        
        normalSearchController = ({
            let search = UISearchController(searchResultsController: nil)
            search.searchResultsUpdater = self.listResults
            search.hidesNavigationBarDuringPresentation = false
            search.searchBar.barStyle = .Default
            search.dimsBackgroundDuringPresentation = false
            search.searchBar.tintColor = UIColor.blackColor()
            search.searchBar.sizeToFit()
            
            return search
        })()
        
        self.showDashboardView()
        self.addKeyboardToggle()
    }
    
    override func didReceiveMemoryWarning() {}
    
    func addPagingViews() {
        self.title = "Search Contacts"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 18.0)!]
        var HKViewColor = UIColor(gradientStyle: UIGradientStyle.LeftToRight, withFrame: self.view.frame, andColors: [FlatHKDark(), FlatHKLight()])
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        var searchControllerArray : [UIViewController] = []
        
        var searchcontroller1 : UITableViewController = listResults
        searchcontroller1.title = "list"
        searchControllerArray.append(searchcontroller1)
        
        var searchcontroller2 : UIViewController = gridResults
        searchcontroller2.title = "grid"
        searchControllerArray.append(searchcontroller2)
        
        var searchcontroller3 : UITableViewController = recentResults
        searchcontroller3.title = "recents"
        searchControllerArray.append(searchcontroller3)
        
        var searchcontroller4 : UITableViewController = favResults
        searchcontroller4.title = "favorites"
        searchControllerArray.append(searchcontroller4)
        
        var searchParameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red: 227/255, green: 44/255, blue: 22/255, alpha: 1.0)),
            .ViewBackgroundColor(HKViewColor),
            .SelectionIndicatorColor(UIColor.whiteColor()),
            .AddBottomMenuHairline(false),
            .MenuItemFont(UIFont(name: "AvenirNext-Regular", size: 17.0)!),
            .MenuMargin(20.0),
            .MenuHeight(30.0),
            .SelectionIndicatorHeight(2.0),
            .MenuItemWidthBasedOnTitleTextWidth(true),
            .SelectedMenuItemLabelColor(UIColor.whiteColor()),
            .UnselectedMenuItemLabelColor(UIColor.lightTextColor())
        ]
        
        searchpageMenu = CAPSPageMenu(viewControllers: searchControllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: searchParameters)
        
        // Optional delegate
        
        self.view.addSubview(searchpageMenu!.view)
        
        var menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        menuBtn.setImage(UIImage(named: "drawerMenu"), forState: UIControlState.Normal)
        menuBtn.setImage(UIImage(named: "drawerMenu"), forState: UIControlState.Highlighted)
        menuBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10)
        menuBtn.addTarget(self, action: "toggleRightDrawer:", forControlEvents:  UIControlEvents.TouchDown)
        var addBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        addBtn.setImage(UIImage(named: "Add"), forState: UIControlState.Normal)
        addBtn.setImage(UIImage(named: "Add"), forState: UIControlState.Highlighted)
        addBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10)
        addBtn.addTarget(self, action: "addNewPerson:", forControlEvents:  UIControlEvents.TouchDown)
        
        var item = UIBarButtonItem(customView: menuBtn)
        var addItem = UIBarButtonItem(customView: addBtn)
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.leftBarButtonItem = addItem
    }
    
    func addKeyboardToggle() {
        var image = UIImage(named: "icon-key-shadow") as UIImage!
        var keyboardButton = UIButton()
        keyboardButton.frame = CGRectMake(self.view.frame.width - 42, self.view.bounds.height - 102, 36, 36)
        keyboardButton.setImage(image, forState: UIControlState.Normal)
        keyboardButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 0)
        keyboardButton.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.5).CGColor
        keyboardButton.layer.cornerRadius = keyboardButton.frame.width/2.0
        keyboardButton.addTarget(self, action: "keyboardButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        blur.frame = keyboardButton.frame
        blur.layer.cornerRadius = blur.frame.width/2.0
        blur.clipsToBounds = true
        self.view.addSubview(blur)
        self.view.addSubview(keyboardButton)
    }
    
    func keyboardButtonClicked(sender: UIButton!) {
        if (keyboardOpen < 1) {
            controller.populateKeys()
        }
        if (keyboardOpen > 0 && contactsSearchController.active) {
            controller.view.hidden = false
        } else {
            controller.refreshData()
            self.presentViewController(contactsSearchController, animated: true, completion: nil)
            addChildViewController(controller)
            controller.view.frame = CGRect(x: 0.0, y: 318.0, width: self.view.frame.width, height: 285.0)
            self.view.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
            controller.view.hidden = false
            contactsSearchController.active = true
            keyboardOpen++
        }
    }
    
    func showDashboardView() {
        let vc = DashboardBarViewController()
        self.view.addSubview(vc.view)
        self.view.bringSubviewToFront(vc.view)
    }
    
    func toggleRightDrawer(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toggleRightDrawer(sender, animated: true)
    }
    
    func addNewPerson(sender: UIBarButtonItem) {
        let npvc = ABNewPersonViewController()
        npvc.newPersonViewDelegate = self
        let nc = UINavigationController(rootViewController:npvc)
        self.presentViewController(nc, animated:true, completion:nil)
    }
    
    func personViewController(personViewController: ABPersonViewController!, shouldPerformDefaultActionForPerson person: ABRecord!, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool {
        return true
    }
    
    func newPersonViewController(newPersonView: ABNewPersonViewController!, didCompleteWithNewPerson person: ABRecord!) {
        listResults.queueFunctions()
        self.dismissViewControllerAnimated(true, completion:nil)
    }
}


