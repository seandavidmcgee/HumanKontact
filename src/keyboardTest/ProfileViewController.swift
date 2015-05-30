//
//  ProfileViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 4/26/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit
import QuartzCore
import CoreGraphics

let offset_HeaderStop:CGFloat = 122.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 54.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 35.0 // The distance between the bottom of the Header and the top of the White Label

class ProfileViewController: UIViewController, UIScrollViewDelegate {

    var image:UIImage? = nil
    var nameLabel:String? = nil
    var coLabel:String? = nil
    var mobileLabel:String? = nil
    var emailLabel:String? = nil
    var homeLabel:String? = nil
    var jobTitleLabel:String? = nil
    
    @IBOutlet var mobileView: UIView!
    @IBOutlet var homeView: UIView!
    @IBOutlet var emailView: UIView!
    @IBOutlet var jobView: UIView!
    @IBOutlet var scrollView:UIScrollView!
    @IBOutlet var bgView: UIView!
    @IBOutlet var avatarImage:UIImageView!
    @IBOutlet var header:UIView!
    @IBOutlet var baseLabel: UILabel!
    @IBOutlet var headerLabel:UILabel!
    @IBOutlet var headerImageView:UIImageView!
    @IBOutlet var headerBlurImageView:UIImageView!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var mobilePhone: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var homePhone: UILabel!
    @IBOutlet var jobTitle: UILabel!
    
    var blurredHeaderImageView:UIImageView?
    var fav: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "back")
        var back = UIButton(frame: CGRect(x: 8, y: 25, width: 20, height: 18))
        back.setImage(image, forState: UIControlState.Normal)
        back.layer.zPosition = 3
        back.addTarget(self, action: "goBack", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(back)
        
        let favImage = UIImage(named: "love")
        fav = UIButton(frame: CGRect(x: (self.view.frame.width - 40), y: 25, width: 32, height: 32))
        fav.setImage(favImage, forState: UIControlState.Normal)
        fav.layer.zPosition = 3
        fav.addTarget(self, action: "favoriteProfile", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(fav)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [FlatHKDark(), FlatHKLight()])
        scrollView.delegate = self
        
        // Header - Image
        headerImageView = UIImageView(frame: header.bounds)
        headerImageView.image = image?.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
        headerImageView.contentMode = UIViewContentMode.ScaleAspectFill
        header.insertSubview(headerImageView!, belowSubview: headerLabel)
        
        // Header - Blurred Image
        headerBlurImageView = UIImageView(frame: header.bounds)
        headerBlurImageView.image = image?.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
        headerBlurImageView.contentMode = UIViewContentMode.ScaleAspectFill
        headerBlurImageView.alpha = 0.0
        header.insertSubview(headerBlurImageView!, belowSubview: headerLabel)
        
        header.clipsToBounds = true
        
        var profileImageView: UIImageView! = UIImageView(frame: avatarImage.bounds)
        profileImageView.image = image
        profileImageView.contentMode = UIViewContentMode.ScaleAspectFill
        avatarImage.insertSubview(profileImageView!, atIndex: 0)
        
        headerLabel.text = nameLabel
        baseLabel.text = nameLabel
        companyLabel.text = coLabel
        mobilePhone.text = mobileLabel
        email.text = emailLabel
        homePhone.text = homeLabel
        jobTitle.text = jobTitleLabel
        
        if ((homePhone.text ) == nil) {
            self.homeView.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func goBack() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        println("back")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            header.layer.transform = headerTransform
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            //  ------------ Label
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - (offset) ), 0)
            headerLabel.layer.transform = labelTransform
            
            //  ------------ Blur
            
            headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
            
            // Avatar -----------
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / avatarImage.bounds.height / 3.5 // Slow down the animation
            let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                
                if avatarImage.layer.zPosition < header.layer.zPosition{
                    header.layer.zPosition = 0
                    header.clipsToBounds = true
                }
                
            }else {
                if avatarImage.layer.zPosition >= header.layer.zPosition{
                    header.layer.zPosition = 2
                    //header.clipsToBounds = false
                }
            }
        }
        
        // Apply Transformations
        
        header.layer.transform = headerTransform
        avatarImage.layer.transform = avatarTransform
    }
    
    func favoriteProfile() {
        let alertView = UIAlertController(title: "Add to Favorites", message: "Would you like to add this person to your Favorites?", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (alertAction) -> Void in
            println("Click of add button")
        }))
        alertView.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }
}
