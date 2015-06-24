//
//  SettingsViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/11/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    var objects = [AnyObject]()
    var parentNavigationController : UINavigationController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 21.0)!]
        
        var menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        menuBtn.setImage(UIImage(named: "drawerMenu"), forState: UIControlState.Normal)
        menuBtn.setImage(UIImage(named: "drawerMenu"), forState: UIControlState.Highlighted)
        menuBtn.addTarget(self, action: Selector("toggleRightDrawer:"), forControlEvents:  UIControlEvents.TouchUpInside)
        var item = UIBarButtonItem(customView: menuBtn)
        self.navigationItem.rightBarButtonItem = item
        
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [FlatHKDark(), FlatHKLight()])
        
        var moreOptions = UIBarButtonItem(title: "More", style:UIBarButtonItemStyle.Plain , target: self, action: "moreOptions:")
        navigationItem.leftBarButtonItem = moreOptions
        let font: UIFont = UIFont(name: "AvenirNext-Regular", size: 17)!
        let color = UIColor.whiteColor()
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font, NSForegroundColorAttributeName: color], forState: .Normal)
        self.refreshData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var shouldBack = false
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParentViewController() && self.shouldBack {
            self.lookupController?.back()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let object = objects[indexPath.row] as! String
        cell.textLabel!.text = object
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("optionsViewController") as? SettingsViewController
        vc!.shouldBack = true
        self.lookupController?.selectOption(indexPath.row)
        self.navigationController?.pushViewController(vc!, animated: true)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func moreOptions(sender: AnyObject?) {
        self.lookupController?.more()
        self.refreshData()
    }
    
    var lookupController : KannuuIndexController? = nil
    var entrySoFar : String? = nil
    
    private func refreshData () {
        let abController = AddressBookController.sharedController()
        self.lookupController = abController.lookupController;
        if let lookupController = self.lookupController {
            self.objects = lookupController.options!
            self.entrySoFar = lookupController.entrySoFar
            self.title = self.entrySoFar;
            self.tableView.reloadData()
        } else {
            abController.askPermissionsWithCompletion({ (success : Bool) -> Void in
                if success == true {
                    self.lookupController = abController.lookupController
                    self.objects = self.lookupController!.options!
                    self.entrySoFar = self.lookupController!.entrySoFar
                    self.title = self.entrySoFar;
                    dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                        self.tableView.reloadData()
                        })
                }
            })
        }
    }
    
    @IBAction func toggleRightDrawer(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toggleRightDrawer(sender, animated: true)
    }
}
