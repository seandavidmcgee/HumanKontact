//
//  FavoritesTableViewController.swift
//  keyboardTest
//
//  Created by Jonathan Carlson on 5/13/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    var parentNavigationController : UINavigationController?
    var pickedImage : UIImage!
    var pickedName : String?
    var pickedCompany : String?
    var pickedMobile : String?
    var pickedHome : String?
    var pickedEmail : String?
    var pickedTitle : String?
    
    var namesArray : [String] = ["David Fletcher", "Zachary Hecker", "Anna Hunt", "Marie Turner", "George Porter"]
    var photoNameArray : [String] = ["man8.jpg", "man7.jpg", "woman3.jpg", "man6.jpg", "woman4.jpg"]
    var sourcesArray : [String] = ["Added from Exchange", "Added from Exchange", "Added from Google", "Added from LinkedIn", "Added from Facebook"]
    var mobileArray : [String] = ["(281) 871-7915", "(214) 226-4204", "(903) 521-9191", "(214) 952-0571", "(972) 386-4129"]
    var homeArray : [String] = ["(214) 718-1141", "(513) 256-4568", "(817) 691-5873", "(713) 408-8791", "(214) 893-0916"]
    var emailArray : [String] = ["david_fletcher@tourconnect.com", "z.g.hecker@gmail.com", "anna.hunt@yahho.com", "georgerporter@live.com", "mturner@projekt202.net"]
    var companyArray : [String] = ["TourConnect", "OrderMyGear", "802 Galleries", "U.S. Concrete", "projekt202"]
    var jobTitleArray : [String] = ["Business Development Manager", "Regional Sales Manager", "Photographer", "Manager, Strategic Planning and Development", "Sr. UI/UX Designer"]
    
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
        pickedCompany = companyArray[indexPath.row]
        pickedMobile = mobileArray[indexPath.row]
        pickedHome = homeArray[indexPath.row]
        pickedEmail = emailArray[indexPath.row]
        pickedTitle = jobTitleArray[indexPath.row]
        
        clickedOnSearchResult()
    }
    
    func clickedOnSearchResult() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("profileViewController") as! ProfileViewController
        vc.modalTransitionStyle = .FlipHorizontal
        let navController = UINavigationController(rootViewController: vc)
        vc.image = pickedImage
        vc.nameLabel = pickedName
        vc.coLabel = pickedCompany
        vc.mobileLabel = pickedMobile
        vc.homeLabel = pickedHome
        vc.emailLabel = pickedEmail
        vc.jobTitleLabel = pickedTitle
        
        self.view.window!.rootViewController!.presentViewController(navController, animated: true, completion: nil)
    }
}
