//
//  RightDrawerViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/10/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

class RightDrawerTableViewController: UITableViewController {
    @IBOutlet var drawerBtns: [UIButton]!
    @IBOutlet var drawerLabels: [UILabel]!
    
    var highlightedIndex: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let rootLabel = drawerLabels[0]
        let rootBtn = drawerBtns[0]
        
        rootLabel.textColor = UIColor.whiteColor()
        rootBtn.backgroundColor = UIColor.whiteColor()
        rootBtn.tintColor = UIColor.blackColor()
        rootBtn.layer.borderColor = UIColor.whiteColor().CGColor
        rootBtn.layer.borderWidth = 2
        rootBtn.layer.cornerRadius = rootBtn.frame.width/2
        rootBtn.clipsToBounds = true
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: <TableViewDataSource>
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        clearHighlightedDrawer(highlightedIndex, animated: false)
        setHighlightedDrawer(indexPath.row-2, animated: false)
        highlightedIndex = indexPath.row-2
        
        if indexPath.row == 2 {
            appDelegate.centerViewController = appDelegate.drawerFavsViewController()
        }; if indexPath.row == 3 {
            appDelegate.centerViewController = appDelegate.drawerContactsViewController()
        }; if indexPath.row == 4 {
            appDelegate.centerViewController = appDelegate.browseContactsViewController()
        }; if indexPath.row == 5 {
            appDelegate.centerViewController = appDelegate.drawerRecentsViewController()
        } else if indexPath.row == 6 {
            appDelegate.centerViewController = appDelegate.drawerSettingsViewController()
        }
    }
    
    func clearHighlightedDrawer(selectedIndex:Int, animated:Bool) {
        var drawerIndicator: UIColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 0.8)
        var drawerBtnIndicator: UIColor = UIColor.clearColor()
        
            drawerLabels[selectedIndex].textColor = drawerIndicator
            drawerBtns[selectedIndex].tintColor = drawerIndicator
            drawerBtns[selectedIndex].backgroundColor = drawerBtnIndicator
            drawerBtns[selectedIndex].layer.borderWidth = 0
    }
    
    func setHighlightedDrawer(selectedIndex:Int, animated:Bool) {
        var drawerIndicator: UIColor = UIColor.whiteColor()
        var drawerBtnIndicator: UIColor = UIColor.blackColor()
        
        drawerLabels[selectedIndex].textColor = drawerIndicator
        drawerBtns[selectedIndex].tintColor = drawerBtnIndicator
        drawerBtns[selectedIndex].backgroundColor = drawerIndicator
        drawerBtns[selectedIndex].layer.borderColor = drawerIndicator.CGColor
        drawerBtns[selectedIndex].layer.borderWidth = 2
        drawerBtns[selectedIndex].layer.cornerRadius = drawerBtns[selectedIndex].frame.width/2
        drawerBtns[selectedIndex].clipsToBounds = true
    }
}

