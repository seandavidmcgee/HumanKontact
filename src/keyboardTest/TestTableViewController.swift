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
    var pickedCompany : String?
    var pickedMobile : String?
    var pickedHome : String?
    var pickedEmail : String?
    var pickedTitle : String?
    
    var namesArray : [String] = ["Lauren Richard", "Nicholas Ray", "Kim White", "Charles Gray", "Timothy Jones", "Sarah Underwood", "William Pearl", "Juan Rodriguez", "Anna Hunt", "Marie Turner", "George Porter", "Zachary Hecker", "David Fletcher", "Lauren Richard", "Nicholas Ray", "Kim White", "Charles Gray", "Timothy Jones", "Sarah Underwood", "William Pearl", "Juan Rodriguez", "Anna Hunt", "Marie Turner", "George Porter", "Zachary Hecker", "David Fletcher"]
    var photoNameArray : [String] = ["woman5.jpg", "man1.jpg", "woman1.jpg", "man2.jpg", "man3.jpg", "woman2.jpg", "man4.jpg", "man5.jpg", "woman3.jpg", "woman4.jpg", "man6.jpg", "man7.jpg", "man8.jpg", "woman5.jpg", "man1.jpg", "woman1.jpg", "man2.jpg", "man3.jpg", "woman2.jpg", "man4.jpg", "man5.jpg", "woman3.jpg", "woman4.jpg", "man6.jpg", "man7.jpg", "man8.jpg"]
    var sourcesArray : [String] = ["Added from Facebook", "Added from Facebook", "Added from Google", "Added from Exchange", "Added from LinkedIn", "Added from LinkedIn", "Added from Exchange", "Added from Facebook", "Added from Google", "Added from Facebook", "Added from LinkedIn", "Added from Exchange", "Added from Exchange", "Added from Facebook", "Added from Facebook", "Added from Google", "Added from Exchange", "Added from LinkedIn", "Added from LinkedIn", "Added from Exchange", "Added from Facebook", "Added from Google", "Added from Facebook", "Added from LinkedIn", "Added from Exchange", "Added from Exchange"]
    var mobileArray : [String] = ["(918) 852-5826", "(214) 505-6754", "(214) 287-7572", "(469) 442-7277", "(214) 886-1094", "(214) 525-1083", "(214) 923-3577", "(817) 360-8610", "(903) 521-9191", "(972) 386-4129", "(214) 952-0571", "(214) 226-4204", "(281) 871-7915", "(918) 852-5826", "(214) 505-6754", "(214) 287-7572", "(469) 442-7277", "(214) 886-1094", "(214) 525-1083", "(214) 923-3577", "(817) 360-8610", "(903) 521-9191", "(972) 386-4129", "(214) 952-0571", "(214) 226-4204", "(281) 871-7915"]
    var homeArray : [String] = ["(214) 404-3824", "(978) 569-3087", "(806) 773-9362", "(469) 682-3334", "(469) 298-9644", "(682) 561-3278", "(214) 245-7921", "(972) 813-0418", "(817) 691-5873", "(214) 893-0916", "(713) 408-8791", "(513) 256-4568", "(214) 718-1141", "(214) 404-3824", "(978) 569-3087", "(806) 773-9362", "(469) 682-3334", "(469) 298-9644", "(682) 561-3278", "(214) 245-7921", "(972) 813-0418", "(817) 691-5873", "(214) 893-0916", "(713) 408-8791", "(513) 256-4568", "(214) 718-1141"]
    var emailArray : [String] = ["lkrichard@gmail.com", "nhray29@yahoo.com", "kwhite@aol.com", "charles.o.gray@gmail.com", "tjjones2@live.com", "sarah_underwood_3@gmail.com", "william.pearl@nm.org", "jrodriguez@cbre.org", "anna.hunt@yahho.com", "mturner@projekt202.net", "georgerporter@live.com", "z.g.hecker@gmail.com", "david_fletcher@tourconnect.com", "lkrichard@gmail.com", "nhray29@yahoo.com", "kwhite@aol.com", "charles.o.gray@gmail.com", "tjjones2@live.com", "sarah_underwood_3@gmail.com", "william.pearl@nm.org", "jrodriguez@cbre.org", "anna.hunt@yahho.com", "mturner@projekt202.net", "georgerporter@live.com", "z.g.hecker@gmail.com", "david_fletcher@tourconnect.com"]
    var companyArray : [String] = ["CarbonQuest LLC", "Bayfront Medical Center", "The Garage: Capital One", "New York Life Insurance", "Northwestern Mutual", "Samsung Telecommunications America", "Northwestern Mutual", "CBRE", "802 Galleries", "projekt202", "U.S. Concrete", "OrderMyGear", "TourConnect", "CarbonQuest LLC", "Bayfront Medical Center", "The Garage: Capital One", "New York Life Insurance", "Northwestern Mutual", "Samsung Telecommunications America", "Northwestern Mutual", "CBRE", "802 Galleries", "projekt202", "U.S. Concrete", "OrderMyGear", "TourConnect"]
    var jobTitleArray : [String] = ["Principal, Strategic Technology", "Human Resources/Recruiter", "Sr. Digital Recruiter", "Licensed Insurance Agent", "Financial Planner", "Channel & Retail Product Trainer", "Finacial Advisor", "Senior Enterprise Architect", "Photographer", "Sr. UI/UX Designer", "Manager, Strategic Planning and Development", "Regional Sales Manager", "Business Development Manager", "Principal, Strategic Technology", "Human Resources/Recruiter", "Sr. Digital Recruiter", "Licensed Insurance Agent", "Financial Planner", "Channel & Retail Product Trainer", "Finacial Advisor", "Senior Enterprise Architect", "Photographer", "Sr. UI/UX Designer", "Manager, Strategic Planning and Development", "Regional Sales Manager", "Business Development Manager"]
    
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
        vc.jobTitleLabel = pickedTitle
        
        parentNavigationController?.pushViewController(vc, animated: true)
    }
}