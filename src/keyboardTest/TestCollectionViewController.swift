//
//  TestCollectionViewController.swift
//  NFTopMenuController
//
//  Created by Niklas Fahl on 12/17/14.
//  Copyright (c) 2014 Niklas Fahl. All rights reserved.
//

import UIKit

class TestCollectionViewController: UICollectionViewController, SwiftPromptsProtocol {
    var reuseIdentifier = "MoodCollectionViewCell"
    var parentNavigationController : UINavigationController?
    var prompt = SwiftPromptsView()
    var pickedImage : UIImage!
    var pickedName : String?
    var pickedCompany : String?
    var pickedMobile : String?
    var pickedHome : String?
    var pickedEmail : String?
    var pickedTitle : String?
    
    var backgroundPhotoNameArray : [String] = ["woman5.jpg", "man1.jpg", "woman1.jpg", "man2.jpg", "man3.jpg", "woman2.jpg", "man4.jpg", "man5.jpg", "woman3.jpg", "woman4.jpg", "man6.jpg", "man7.jpg", "man8.jpg"]
    var photoNameArray : [String] = ["Lauren", "Nicholas", "Kim", "Charles", "Timothy", "Sarah", "William", "Juan", "Anna", "Marie", "George", "Zachary", "David"]
    var lastNameArray : [String] = [" Richard", " Ray", " White", " Gray", " Jones", " Underwood", " Pearl", " Rodriguez", " Hunt", " Turner", " Porter", " Hecker", " Fletcher"]
    var mobileArray : [String] = ["(918) 852-5826", "(214) 505-6754", "(214) 287-7572", "(469) 442-7277", "(214) 886-1094", "(214) 525-1083", "(214) 923-3577", "(817) 360-8610", "(903) 521-9191", "(972) 386-4129", "(214) 952-0571", "(214) 226-4204", "(281) 871-7915"]
    var homeArray : [String] = ["(214) 404-3824", "(978) 569-3087", "(806) 773-9362", "(469) 682-3334", "(469) 298-9644", "(682) 561-3278", "(214) 245-7921", "(972) 813-0418", "(817) 691-5873", "(214) 893-0916", "(713) 408-8791", "(513) 256-4568", "(214) 718-1141"]
    var emailArray : [String] = ["lkrichard@gmail.com", "nhray29@yahoo.com", "kwhite@aol.com", "charles.o.gray@gmail.com", "tjjones2@live.com", "sarah_underwood_3@gmail.com", "william.pearl@nm.org", "jrodriguez@cbre.org", "anna.hunt@yahho.com", "mturner@projekt202.net", "georgerporter@live.com", "z.g.hecker@gmail.com", "david_fletcher@tourconnect.com"]
    var companyArray : [String] = ["CarbonQuest LLC", "Bayfront Medical Center", "The Garage: Capital One", "New York Life Insurance", "Northwestern Mutual", "Samsung Telecommunications America", "Northwestern Mutual", "CBRE", "802 Galleries", "projekt202", "U.S. Concrete", "OrderMyGear", "TourConnect"]
    var jobTitleArray : [String] = ["Principal, Strategic Technology", "Human Resources/Recruiter", "Sr. Digital Recruiter", "Licensed Insurance Agent", "Financial Planner", "Channel & Retail Product Trainer", "Finacial Advisor", "Senior Enterprise Architect", "Photographer", "Sr. UI/UX Designer", "Manager, Strategic Planning and Development", "Regional Sales Manager", "Business Development Manager"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.registerNib(UINib(nibName: "MoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.collectionView!.showsVerticalScrollIndicator = false
        super.viewDidAppear(animated)
        self.collectionView!.showsVerticalScrollIndicator = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return photoNameArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : MoodCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MoodCollectionViewCell
    
        // Configure the cell
        cell.backgroundImageView.image = UIImage(named: backgroundPhotoNameArray[indexPath.row])
        cell.backgroundImageView.layer.cornerRadius = CGRectGetWidth(cell.backgroundImageView.frame)/2.0
        cell.firstNameTitleLabel.text = photoNameArray[indexPath.row]
        cell.lastNameTitleLabel.text = lastNameArray[indexPath.row]
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let image = UIImage(named: backgroundPhotoNameArray[indexPath.row])!
        let size = CGSizeMake(50, 50)
        let hasAlpha = false
        let scale: CGFloat = 2.0 // Automatically use scale factor of main screen
        
        pickedName = photoNameArray[indexPath.row] + "" + lastNameArray[indexPath.row]
        pickedImage = UIImage(named: backgroundPhotoNameArray[indexPath.row])!
        pickedCompany = companyArray[indexPath.row]
        pickedMobile = mobileArray[indexPath.row]
        pickedHome = homeArray[indexPath.row]
        pickedEmail = emailArray[indexPath.row]
        pickedTitle = jobTitleArray[indexPath.row]
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Create an instance of SwiftPromptsView and assign its delegate
        prompt = SwiftPromptsView(frame: self.view.bounds)
        prompt.delegate = self
        
        //Set the properties for the background
        prompt.setColorWithTransparency(UIColor.clearColor())
        
        //Set the properties of the promt
        prompt.setPromtHeader(photoNameArray[indexPath.row] + "" + lastNameArray[indexPath.row])
        prompt.setPromptContentTxtSize(16.0)
        prompt.setPromptContentTxtColor(UIColor.whiteColor())
        prompt.setPromptContentText("Mobile" + mobileArray[indexPath.row])
        prompt.setPromptDismissIconColor(UIColor(patternImage: scaledImage))
        prompt.setPromptDismissIconVisibility(true)
        prompt.setPromptTopBarVisibility(true)
        prompt.setPromptBottomBarVisibility(false)
        prompt.setPromptTopLineVisibility(false)
        prompt.setPromptBottomLineVisibility(true)
        prompt.setPromptWidth(self.view.bounds.width * 0.75)
        prompt.setPromptHeight(self.view.bounds.width * 0.55)
        prompt.setPromptBackgroundColor(UIColor(red: 94.0/255.0, green: 100.0/255.0, blue: 112.0/255.0, alpha: 0.85))
        prompt.setPromptHeaderBarColor(UIColor(red: 50.0/255.0, green: 58.0/255.0, blue: 71.0/255.0, alpha: 0.8))
        prompt.setPromptHeaderTxtColor(UIColor.whiteColor())
        prompt.setPromptBottomLineColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
        prompt.setPromptButtonDividerColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
        prompt.enableDoubleButtonsOnPrompt()
        prompt.setMainButtonText("View Profile")
        prompt.setMainButtonColor(UIColor.whiteColor())
        prompt.setSecondButtonColor(UIColor.whiteColor())
        prompt.setSecondButtonText("Cancel")
        
        self.view.addSubview(prompt)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    // MARK: - Delegate functions for the prompt
    
    func clickedOnTheMainButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("profileViewController") as! ProfileViewController
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        let navController = UINavigationController(rootViewController: vc)
        vc.image = pickedImage
        vc.nameLabel = pickedName
        vc.coLabel = pickedCompany
        vc.jobTitleLabel = pickedTitle!
        
        self.view.window!.rootViewController!.presentViewController(navController, animated: true, completion: nil)
        prompt.dismissPrompt()
    }
    
    func clickedOnTheSecondButton() {
        println("Clicked on the second button")
        prompt.dismissPrompt()
        
    }
    
    func promptWasDismissed() {
        println("Dismissed the prompt")
    }
}
