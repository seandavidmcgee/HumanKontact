//
//  SettingsViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/11/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UITableViewController {
    var options: NSArray!
    var entrySoFar: NSString!
    weak var lookupController: KannuuIndexController!
    
    
    var parentNavigationController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 21.0)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [FlatHKDark(), FlatHKLight()])
        
        var moreOptions = UIBarButtonItem(title: "More", style:UIBarButtonItemStyle.Plain , target: self, action: "moreOptions")
        navigationItem.rightBarButtonItem = moreOptions
        let font: UIFont = UIFont(name: "AvenirNext-Regular", size: 17)!
        let color = UIColor.whiteColor()
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font, NSForegroundColorAttributeName: color], forState: .Normal)
        self.refreshData()
    }
    
    override func didReceiveMemoryWarning() {}
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.options.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        var stringValue: NSString = self.options[indexPath.row] as! NSString;
        cell.textLabel!.text = stringValue as String;
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("optionsViewController") as! SettingsViewController
        self.lookupController.selectOption(indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func refreshData() {
        var abController: AddressBookController = AddressBookController.sharedController()
        self.lookupController = abController.lookupController
        
            self.options = self.lookupController.options()
            self.entrySoFar = self.lookupController.entrySoFar()
            self.title = self.entrySoFar as? String
            self.tableView.reloadData()
    }
    
    @IBAction func moreOptions() {
        self.lookupController.more()
        self.refreshData()
    }
    
    @IBAction func toggleRightDrawer(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toggleRightDrawer(sender, animated: true)
    }
}
