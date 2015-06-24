//
//  FriendTableViewCell.swift
//  NFTopMenuController
//
//  Created by Niklas Fahl on 12/17/14.
//  Copyright (c) 2014 Niklas Fahl. All rights reserved.
//

import UIKit
import Foundation

class FriendTableViewCell: UITableViewCell {
    var photoImageView: UIImageView! = UIImageView()
    var nameLabel: UILabel! = UILabel()
    var radius: CGFloat = 0
    var friendCardView: UIView! = UIView()
    var connectBtnX: CGFloat! = 74
    var homeCallBtn: UIButton! = UIButton()
    var workCallBtn: UIButton! = UIButton()
    var mobileCallBtn: UIButton! = UIButton()
    var mobileTxtBtn: UIButton! = UIButton()
    var iPhoneCallBtn: UIButton! = UIButton()
    var iPhoneTxtBtn: UIButton! = UIButton()
    var emailBtn: UIButton! = UIButton()
    var secondaryEmailBtn: UIButton! = UIButton()
    var homeCallBtnImage: UIImage! = UIImage(named:"CallHome")
    var workCallBtnImage: UIImage! = UIImage(named:"CallWork")
    var mobileCallBtnImage: UIImage! = UIImage(named:"CallMobile")
    var iPhoneCallBtnImage: UIImage! = UIImage(named:"CalliPhone")
    var mobileTxtBtnImage: UIImage! = UIImage(named:"Messaging")
    var iPhoneTxtBtnImage: UIImage! = UIImage(named:"MessageiPhone")
    var emailBtnImage: UIImage! = UIImage(named:"Email")
    var sourceTag: UIView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let initialViewWidth = appDelegate.centerViewController.view.frame.width
        
        self.frame = CGRect(x: 0, y: 0, width: initialViewWidth, height: 74)
        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        configureView()
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
        configureView()
    }
    
    func configureView() {
        // Initialization code
        friendCardView.frame = CGRect(x: 5, y: 10, width: self.frame.width-10, height: self.frame.height-10)
        friendCardView.backgroundColor = UIColor(gradientStyle: UIGradientStyle.LeftToRight, withFrame: friendCardView.frame, andColors: [FlatHKDark(), UIColor(red: 0, green: 0, blue: 13/255, alpha: 0.4)])
        friendCardView.layer.cornerRadius = radius
        applyCurvedShadow(friendCardView)
        friendCardView.tag = 94
        
        photoImageView.frame = CGRect(x: 14, y: 6, width: 42, height: 42)
        photoImageView.layer.cornerRadius = photoImageView!.frame.width / 2.0
        photoImageView.clipsToBounds = true
        friendCardView.addSubview(photoImageView)
        
        nameLabel.frame = CGRect(x: 74, y: 3, width: 221, height: 27)
        nameLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)
        nameLabel.textColor = UIColor.whiteColor()
        friendCardView.addSubview(nameLabel)
        
        homeCallBtn.frame = CGRect(x: connectBtnX, y: 28, width: 36, height: 36)
        homeCallBtn.setImage(homeCallBtnImage, forState: UIControlState.Normal)
        homeCallBtn.layer.cornerRadius = homeCallBtn.frame.width / 2.0
        homeCallBtn.contentMode = UIViewContentMode.ScaleAspectFit
        homeCallBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        homeCallBtn.addTarget(self, action: "didPressButton:", forControlEvents: .TouchUpInside)
        homeCallBtn.tag = 95
        friendCardView.addSubview(homeCallBtn)
        
        workCallBtn.frame = CGRect(x: connectBtnX, y: 28, width: 36, height: 36)
        workCallBtn.setImage(workCallBtnImage, forState: UIControlState.Normal)
        workCallBtn.layer.cornerRadius = workCallBtn.frame.width / 2.0
        workCallBtn.contentMode = UIViewContentMode.ScaleAspectFit
        workCallBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        workCallBtn.addTarget(self, action: "didPressButton:", forControlEvents: .TouchUpInside)
        workCallBtn.tag = 96
        friendCardView.addSubview(workCallBtn)
        
        mobileCallBtn.frame = CGRect(x: connectBtnX, y: 28, width: 36, height: 36)
        mobileCallBtn.setImage(mobileCallBtnImage, forState: UIControlState.Normal)
        mobileCallBtn.layer.cornerRadius = mobileCallBtn.frame.width / 2.0
        mobileCallBtn.contentMode = UIViewContentMode.ScaleAspectFit
        mobileCallBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        mobileCallBtn.addTarget(self, action: "didPressButton:", forControlEvents: .TouchUpInside)
        mobileCallBtn.tag = 97
        friendCardView.addSubview(mobileCallBtn)
        
        mobileTxtBtn.frame = CGRect(x: connectBtnX, y: 28, width: 36, height: 36)
        mobileTxtBtn.setImage(mobileTxtBtnImage, forState: UIControlState.Normal)
        mobileTxtBtn.layer.cornerRadius = mobileTxtBtn.frame.width / 2.0
        mobileTxtBtn.contentMode = UIViewContentMode.ScaleAspectFit
        mobileTxtBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        mobileTxtBtn.addTarget(self, action: "didPressButton:", forControlEvents: .TouchUpInside)
        mobileTxtBtn.tag = 98
        friendCardView.addSubview(mobileTxtBtn)
        
        iPhoneCallBtn.frame = CGRect(x: connectBtnX, y: 28, width: 36, height: 36)
        iPhoneCallBtn.setImage(iPhoneCallBtnImage, forState: UIControlState.Normal)
        iPhoneCallBtn.layer.cornerRadius = iPhoneCallBtn.frame.width / 2.0
        iPhoneCallBtn.contentMode = UIViewContentMode.ScaleAspectFit
        iPhoneCallBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        iPhoneCallBtn.addTarget(self, action: "didPressButton:", forControlEvents: .TouchUpInside)
        iPhoneCallBtn.tag = 97
        friendCardView.addSubview(iPhoneCallBtn)
        
        iPhoneTxtBtn.frame = CGRect(x: connectBtnX, y: 28, width: 36, height: 36)
        iPhoneTxtBtn.setImage(iPhoneTxtBtnImage, forState: UIControlState.Normal)
        iPhoneTxtBtn.layer.cornerRadius = iPhoneTxtBtn.frame.width / 2.0
        iPhoneTxtBtn.contentMode = UIViewContentMode.ScaleAspectFit
        iPhoneTxtBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        iPhoneTxtBtn.addTarget(self, action: "didPressButton:", forControlEvents: .TouchUpInside)
        iPhoneTxtBtn.tag = 98
        friendCardView.addSubview(iPhoneTxtBtn)
        
        emailBtn.frame = CGRect(x: connectBtnX, y: 28, width: 36, height: 36)
        emailBtn.setImage(emailBtnImage, forState: UIControlState.Normal)
        emailBtn.layer.cornerRadius = emailBtn.frame.width / 2.0
        emailBtn.contentMode = UIViewContentMode.ScaleAspectFit
        emailBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        emailBtn.addTarget(self, action: "didPressButton:", forControlEvents: .TouchUpInside)
        emailBtn.tag = 99
        friendCardView.addSubview(emailBtn)
        
        sourceTag.frame = CGRect(x: friendCardView.frame.width-2, y: 0, width: 2, height: friendCardView.frame.height)
        sourceTag.backgroundColor = UIColor(red: 33/255, green: 192/255, blue: 100/255, alpha: 1.0)
        friendCardView.addSubview(sourceTag)
        
        self.contentView.addSubview(friendCardView)
    }
    
    func configureSecondaryBtns() {
        secondaryEmailBtn.frame = CGRect(x: connectBtnX, y: 28, width: 36, height: 36)
        secondaryEmailBtn.setImage(emailBtnImage, forState: UIControlState.Normal)
        secondaryEmailBtn.layer.cornerRadius = secondaryEmailBtn.frame.width / 2.0
        secondaryEmailBtn.contentMode = UIViewContentMode.ScaleAspectFit
        secondaryEmailBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        secondaryEmailBtn.addTarget(self, action: "didPressButton:", forControlEvents: .TouchUpInside)
        secondaryEmailBtn.tag = 99
        friendCardView.addSubview(secondaryEmailBtn)
    }
    
    func applyCurvedShadow(view: UIView) {
        let size = view.bounds.size
        let width = size.width
        let height = size.height
        let depth = CGFloat(11.0)
        let lessDepth = 0.8 * depth
        let curvyness = CGFloat(5)
        let radius = CGFloat(1)
        
        var path = UIBezierPath()
        
        // top left
        path.moveToPoint(CGPoint(x: radius, y: height))
        
        // top right
        path.addLineToPoint(CGPoint(x: width - 2*radius, y: height))
        
        // bottom right + a little extra
        path.addLineToPoint(CGPoint(x: width - 2*radius, y: height + depth))
        
        // path to bottom left via curve
        path.addCurveToPoint(CGPoint(x: radius, y: height + depth),
            controlPoint1: CGPoint(x: width - curvyness, y: height + lessDepth - curvyness),
            controlPoint2: CGPoint(x: curvyness, y: height + lessDepth - curvyness))
        
        var layer = view.layer
        layer.shadowPath = path.CGPath
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: -3)
    }
    
    func didPressButton(button:UIButton) {
        var infoToSend: String! = button.titleLabel!.text!
        if (infoToSend != nil) {
            if (button.tag == 95 || button.tag == 96 || button.tag == 97) {
                callNumber(infoToSend)
            }
            if (button.tag == 98) {
                textNumber(infoToSend)
            }
            if (button.tag == 99) {
                emailPressed(infoToSend)
            }
        } else {
            return
        }
    }
    
    private func callNumber(phoneNumber:String) {
        var strippedPhoneNumber = phoneNumber.stringByReplacingOccurrencesOfString("[^0-9 ]", withString: "", options: NSStringCompareOptions.RegularExpressionSearch, range:nil);
        var cleanNumber = strippedPhoneNumber.removeWhitespace()
        cleanNumber.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (count(cleanNumber.utf16) > 1){
            if let phoneCallURL:NSURL = NSURL(string: "tel://\(cleanNumber)") {
                let application:UIApplication = UIApplication.sharedApplication()
                if (application.canOpenURL(phoneCallURL)) {
                    application.openURL(phoneCallURL);
                }
            }
        } else {
            let alert = UIAlertView()
            alert.title = "Sorry!"
            alert.message = "Phone number is not available."
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
    }
    
    private func textNumber(phoneNumber:String) {
        var strippedPhoneNumber = phoneNumber.stringByReplacingOccurrencesOfString("[^0-9 ]", withString: "", options: NSStringCompareOptions.RegularExpressionSearch, range:nil);
        var cleanNumber = strippedPhoneNumber.removeWhitespace()
        cleanNumber.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (count(cleanNumber.utf16) > 1){
            if let textMessageURL:NSURL = NSURL(string: "sms://\(cleanNumber)") {
                let application:UIApplication = UIApplication.sharedApplication()
                if (application.canOpenURL(textMessageURL)) {
                    application.openURL(textMessageURL);
                }
            }
        } else {
            let alert = UIAlertView()
            alert.title = "Sorry!"
            alert.message = "Phone number is not available for text messaging."
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
    }
    
    private func emailPressed(email:String) {
        if let emailUrl:NSURL = NSURL(string: "mailto:\(email)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(emailUrl)) {
                application.openURL(emailUrl);
            }
        }
    }
}
