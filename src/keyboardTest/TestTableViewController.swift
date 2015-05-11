//
//  TestTableViewController.swift
//  NFTopMenuController
//
//  Created by Niklas Fahl on 12/17/14.
//  Copyright (c) 2014 Niklas Fahl. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
    var parentNavigationController : UINavigationController?
    var pickedImage : UIImage!
    var pickedName : String?
    
    var namesArray : [String] = ["Lauren Richard", "Nicholas Ray", "Kim White", "Charles Gray", "Timothy Jones", "Sarah Underwood", "William Pearl", "Juan Rodriguez", "Anna Hunt", "Marie Turner", "George Porter", "Zachary Hecker", "David Fletcher"]
    var photoNameArray : [String] = ["woman5.jpg", "man1.jpg", "woman1.jpg", "man2.jpg", "man3.jpg", "woman2.jpg", "man4.jpg", "man5.jpg", "woman3.jpg", "woman4.jpg", "man6.jpg", "man7.jpg", "man8.jpg"]
    var sourcesArray : [String] = ["Added from Facebook", "Added from Facebook", "Added from Google", "Added from Exchange", "Added from LinkedIn", "Added from LinkedIn", "Added from Exchange", "Added from Facebook", "Added from Google", "Added from Facebook", "Added from LinkedIn", "Added from Exchange", "Added from Exchange"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendTableViewCell")
        self.tableView.registerNib(UINib(nibName: "ProfileMenuCell", bundle: nil), forCellReuseIdentifier: "ProfileMenuCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.showsVerticalScrollIndicator = false
        super.viewDidAppear(animated)
        self.tableView.showsVerticalScrollIndicator = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return namesArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : FriendTableViewCell = tableView.dequeueReusableCellWithIdentifier("FriendTableViewCell") as! FriendTableViewCell
        let quickActions : ProfileMenuCell = tableView.dequeueReusableCellWithIdentifier("ProfileMenuCell") as! ProfileMenuCell
        
        // Configure the cell...
        cell.nameLabel.text = namesArray[indexPath.row]
        cell.sourceLabel.text = sourcesArray[indexPath.row]
        cell.photoImageView.image = UIImage(named: photoNameArray[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 47.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)  {
        pickedName = namesArray[indexPath.row]
        pickedImage = UIImage(named: photoNameArray[indexPath.row])!
        clickedOnSearchResult()
    }
    
    func clickedOnSearchResult() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("profileViewController") as! ProfileViewController
        vc.modalTransitionStyle = .FlipHorizontal
        let navController = UINavigationController(rootViewController: vc)
        vc.image = pickedImage
        vc.nameLabel = pickedName
        self.view.window!.rootViewController!.presentViewController(navController, animated: true, completion: nil)
    }
}