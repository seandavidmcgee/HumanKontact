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

let offset_HeaderStop:CGFloat = 150.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 111.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 35.0 // The distance between the bottom of the Header and the top of the White Label

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    var parentNavigationController : UINavigationController?
    var image:UIImage? = nil
    var nameLabel:String? = nil
    
    @IBOutlet var scrollView:UIScrollView!
    @IBOutlet var bgView: UIView!
    @IBOutlet var avatarImage:UIImageView!
    @IBOutlet var header:UIView!
    @IBOutlet var baseLabel: UILabel!
    @IBOutlet var headerLabel:UILabel!
    @IBOutlet var headerImageView:UIImageView!
    @IBOutlet var headerBlurImageView:UIImageView!
    var blurredHeaderImageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [FlatHKDark(), FlatHKLight()])
        scrollView.delegate = self
        
        var backToSearch = UIBarButtonItem(title: "Back", style:UIBarButtonItemStyle.Plain , target: self, action: "backToSearch")
        navigationItem.leftBarButtonItem = backToSearch
        navigationController?.navigationBar.backgroundColor = UIColor(red: 1/255, green: 20/255, blue: 55/255, alpha: 0.4)
        navigationController?.navigationBar.barStyle = UIBarStyle(rawValue: 2)!
        let font: UIFont = UIFont(name: "AvenirNext-Regular", size: 17)!
        let color = UIColor.whiteColor()
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font, NSForegroundColorAttributeName: color], forState: .Normal)
    }
    
    override func viewWillAppear(animated: Bool) {
        // Header - Image
        headerImageView = UIImageView(frame: CGRectMake(0, 0, view.frame.width, 170))
        headerImageView.image = image?.blurredImageWithRadius(20, iterations: 20, tintColor: UIColor.flatHKDarkColor())
        headerImageView.contentMode = UIViewContentMode.ScaleAspectFill
        header.insertSubview(headerImageView!, belowSubview: headerLabel)
        
        // Header - Blurred Image
        headerBlurImageView = UIImageView(frame: CGRectMake(0, 0, view.frame.width, 170))
        headerBlurImageView.image = image?.blurredImageWithRadius(14, iterations: 20, tintColor: UIColor.flatHKDarkColor())
        headerBlurImageView.contentMode = UIViewContentMode.ScaleAspectFill
        headerBlurImageView.alpha = 0.0
        header.insertSubview(headerBlurImageView!, belowSubview: headerLabel)
        
        header.clipsToBounds = true
        
        var profileImageView: UIImageView! = UIImageView(frame: avatarImage.bounds)
        profileImageView.image = image!
        profileImageView.contentMode = UIViewContentMode.ScaleAspectFill
        avatarImage.insertSubview(profileImageView!, atIndex: 0)
        
        //headerLabel.text = nameLabel
        baseLabel.text = nameLabel
    }
    
    func backToSearch() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            
            if (offset > 236) {
                self.title = nameLabel
            }
            else {
                self.title = ""
            }
            
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
                }
                
            }else {
                if avatarImage.layer.zPosition >= header.layer.zPosition{
                    header.layer.zPosition = 2
                }
            }
        }
        
        // Apply Transformations
        
        header.layer.transform = headerTransform
        
        avatarImage.layer.transform = avatarTransform
    }
    
    @IBAction func shamelessActionThatBringsYouToMyTwitterProfile() {
        
        if !UIApplication.sharedApplication().openURL(NSURL(string:"twitter://user?screen_name=bitwaker")!){
            UIApplication.sharedApplication().openURL(NSURL(string:"https://twitter.com/bitwaker")!)
        }
    }
}
