//
//  FavoritesViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/11/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

class FavoritesViewController: UIViewController, CAPSPageMenuDelegate {
    
    var favoritespageMenu : CAPSPageMenu?
    var parentNavigationController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 21.0)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [FlatHKDark(), FlatHKLight()])
        
        var favoritesControllerArray : [UIViewController] = []
        
        var favoritescontroller1 : TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
        favoritescontroller1.title = ""
        favoritesControllerArray.append(favoritescontroller1)
        
        var favoritesParameters: [String: AnyObject] = ["scrollMenuBackgroundColor": UIColor.clearColor(),
            "viewBackgroundColor": UIColor.clearColor(),
            "selectionIndicatorColor": UIColor.whiteColor(),
            "addBottomMenuHairline": false,
            "menuItemFont": UIFont(name: "AvenirNext-Regular", size: 17.0)!,
            "menuMargin": 20.0,
            "menuHeight": 0.0,
            "selectionIndicatorHeight": 0.0,
            "menuItemWidthBasedOnTitleTextWidth": true,
            "selectedMenuItemLabelColor": UIColor.whiteColor()]
        var height = view.frame.height;
        
        favoritespageMenu = CAPSPageMenu(viewControllers: favoritesControllerArray, frame: CGRectMake(0, 0, view.frame.width, height), options: favoritesParameters)
        
        // Optional delegate
        favoritespageMenu!.delegate = self
        
        self.view.addSubview(favoritespageMenu!.view)
    }
    
    override func didReceiveMemoryWarning() {}
    
    @IBAction func toggleRightDrawer(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toggleRightDrawer(sender, animated: true)
    }
}
