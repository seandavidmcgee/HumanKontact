//
//  GridViewControllerExtensions.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/30/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import Foundation
import UIKit

extension GridViewController: UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // Return the number of sections.
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (contactsSearchController.active || normalSearchController.active)
        {
            return self.searchArray.count
        } else
        {
            return indexedPeople.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FriendCollectionViewCell", forIndexPath: indexPath) as! FriendCollectionViewCell
        
        if (contactsSearchController.active || normalSearchController.active)
        {
            cell.backgroundImageView.image = self.searchArray[indexPath.row]["Thumbnail"] as? UIImage
            let firstName = self.searchArray[indexPath.row]["FirstName"] as? String
            let lastName = self.searchArray[indexPath.row]["LastName"] as? String
            cell.firstNameTitleLabel!.text = firstName
            cell.lastNameTitleLabel!.text = lastName
            return cell
        }
            
        else
        {
            cell.backgroundImageView.image = indexedPeople[indexPath.row]["Thumbnail"] as? UIImage
            cell.backgroundImageView!.layer.cornerRadius = CGRectGetWidth(cell.backgroundImageView!.frame)/2.0
            let firstName = indexedPeople[indexPath.row]["FirstName"] as? String
            let lastName = indexedPeople[indexPath.row]["LastName"] as? String
            cell.firstNameTitleLabel!.text = firstName
            cell.lastNameTitleLabel!.text = lastName
            return cell
        }
    }
}

extension GridViewController: UICollectionViewDelegate
{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if contactsSearchController.active {
            controller.view.hidden = true
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        var record: ABRecordRef!
        let size = CGSizeMake(50, 50)
        let hasAlpha = false
        let scale: CGFloat = 2.0 // Automatically use scale factor of main screen
        
        var profilePhone: String! = ""
        var profileEmail: String! = ""
        
        //Create an instance of SwiftPromptsView and assign its delegate
        prompt = SwiftPromptsView(frame: self.view.bounds)
        prompt.delegate = self
        
        //Set the properties for the background
        prompt.setColorWithTransparency(UIColor.clearColor())
        
        //Reset profile action properties
        prompt.homeCallButton.hidden = true
        prompt.homeCallButton.setTitle("", forState: UIControlState.Normal)
        prompt.workCallButton.hidden = true
        prompt.workCallButton.setTitle("", forState: UIControlState.Normal)
        prompt.mobileCallButton.hidden = true
        prompt.mobileCallButton.setTitle("", forState: UIControlState.Normal)
        prompt.messageButton.hidden = true
        prompt.messageButton.setTitle("", forState: UIControlState.Normal)
        prompt.iPhoneCallButton.hidden = true
        prompt.iPhoneCallButton.setTitle("", forState: UIControlState.Normal)
        prompt.iPhoneMessageButton.hidden = true
        prompt.iPhoneMessageButton.setTitle("", forState: UIControlState.Normal)
        prompt.emailButton.hidden = true
        prompt.emailButton.setTitle("", forState: UIControlState.Normal)
        prompt.secondEmailButton.hidden = true
        prompt.secondEmailButton.setTitle("", forState: UIControlState.Normal)
        prompt.workCallButton.transform = CGAffineTransformMakeTranslation(0, 0)
        prompt.mobileCallButton.transform = CGAffineTransformMakeTranslation(0, 0)
        prompt.messageButton.transform = CGAffineTransformMakeTranslation(0, 0)
        prompt.iPhoneCallButton.transform = CGAffineTransformMakeTranslation(0, 0)
        prompt.iPhoneMessageButton.transform = CGAffineTransformMakeTranslation(0, 0)
        prompt.emailButton.transform = CGAffineTransformMakeTranslation(0, 0)
        prompt.secondEmailButton.transform = CGAffineTransformMakeTranslation(0, 0)
        
        if (contactsSearchController.active || normalSearchController.active)
        {
            record = self.searchArray[indexPath.row]["abrecord"] as ABRecordRef!
            
            var name: String? = self.searchArray[indexPath.row]["fullName"] as! String?
            recentPeople.append(name!)
            pickedName = name
            
            var image: UIImage! = self.searchArray[indexPath.row]["Thumbnail"] as! UIImage!
            var imageBG: UIImage! = self.searchArray[indexPath.row]["FullImage"] as! UIImage!
            pickedBG = imageBG
            pickedImage = image
            
            var company: String? = self.searchArray[indexPath.row]["Organization"] as! String?
            pickedCompany = company
            
            var phonesRef: ABMultiValueRef! = ABRecordCopyValue(record, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef
            if (phonesRef != nil)  {
                for var i:Int = 0; i < ABMultiValueGetCount(phonesRef); i++ {
                    if (ABMultiValueCopyLabelAtIndex(phonesRef, i) != nil) {
                        var label: String = ABMultiValueCopyLabelAtIndex(phonesRef, i).takeRetainedValue() as NSString as! String
                        var phone: String = ABMultiValueCopyValueAtIndex(phonesRef, i).takeRetainedValue() as! NSString as String
                        var localLabel: String = ABAddressBookCopyLocalizedLabel( label ).takeRetainedValue() as NSString as! String
                        localLabel.capitalizedString
                        
                        var localPhone = [localLabel: phone]
                        phonesArray.append(localPhone)
                    } else {
                        var label: String = "phone "
                        var phone: String = ABMultiValueCopyValueAtIndex(phonesRef, i).takeRetainedValue() as! NSString as String
                        var localPhone = [label: phone]
                        phonesArray.append(localPhone)
                    }
                }
            }
            
            var emailsRef: ABMultiValueRef! = ABRecordCopyValue(record, kABPersonEmailProperty).takeRetainedValue() as ABMultiValueRef
            if (emailsRef != nil)  {
                for var j:Int = 0; j < ABMultiValueGetCount(emailsRef); j++ {
                    if (ABMultiValueCopyLabelAtIndex(emailsRef, j) != nil) {
                        var label: String = ABMultiValueCopyLabelAtIndex(emailsRef, j).takeRetainedValue() as NSString as! String
                        var email: String = ABMultiValueCopyValueAtIndex(emailsRef, j).takeRetainedValue() as! NSString as String
                        var localLabel: String = ABAddressBookCopyLocalizedLabel( label ).takeRetainedValue() as NSString as! String
                        localLabel.capitalizedString
                        
                        var localEmail = [localLabel: email]
                        emailsArray.append(localEmail)
                    } else {
                        var label: String = "email "
                        var email: String = ABMultiValueCopyValueAtIndex(emailsRef, j).takeRetainedValue() as! NSString as String
                        var localEmail = [label: email]
                        emailsArray.append(localEmail)
                    }
                }
            }
            var jobTitle: String? = self.searchArray[indexPath.row]["JobTitle"] as! String?
            pickedTitle = jobTitle!
            
        }
            
        else
        {
            record = indexedPeople[indexPath.row]["abrecord"] as ABRecordRef!
            var secondaryTranslate: CGFloat = 60 * CGFloat(promptPhonesArray.count + 1)
            
            var name: String? = indexedPeople[indexPath.row]["fullName"] as! String?
            recentPeople.append(name!)
            pickedName = name!
            
            var phonesRef: ABMultiValueRef! = ABRecordCopyValue(record, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef!
            var phoneNumberCount: Int = ABMultiValueGetCount(phonesRef)
            
            var image: UIImage! = indexedPeople[indexPath.row]["Thumbnail"] as! UIImage!
            var imageBG: UIImage! = indexedPeople[indexPath.row]["FullImage"] as! UIImage!
            pickedBG = imageBG
            pickedImage = image
            
            var company: String? = indexedPeople[indexPath.row]["Organization"] as! String?
            pickedCompany = company!
            
            if (phonesRef != nil)  {
                for var i:Int = 0; i < phoneNumberCount; i++ {
                    if (ABMultiValueCopyLabelAtIndex(phonesRef, i) != nil) {
                        var label: String = ABMultiValueCopyLabelAtIndex(phonesRef, i).takeRetainedValue() as NSString as! String
                        var phone: String = ABMultiValueCopyValueAtIndex(phonesRef, i).takeRetainedValue() as! NSString as String
                        var localLabel: String = ABAddressBookCopyLocalizedLabel( label ).takeRetainedValue() as NSString as! String
                        localLabel.capitalizedString
                        
                        var localPhone = [localLabel: phone]
                        phonesArray.append(localPhone)
                        promptPhonesArray.append(localPhone)
                    } else {
                        var label: String = "phone "
                        var phone: String = ABMultiValueCopyValueAtIndex(phonesRef, i).takeRetainedValue() as! NSString as String
                        var localPhone = [label: phone]
                        phonesArray.append(localPhone)
                        promptPhonesArray.append(localPhone)
                    }
                }
                for phone in promptPhonesArray {
                    // Grab each key, value pair from the person dictionary
                        if let valI = phone["iPhone"] {
                            prompt.iPhoneIncluded = true
                            profilePhone = "iPhone : \(valI)"
                            prompt.enableiPhoneButtonOnPrompt()
                            prompt.iPhoneCallButton.setTitle("\(valI)", forState: UIControlState.Normal)
                            prompt.iPhoneCallButton.hidden = false
                            prompt.iPhoneMessageButton.setTitle("\(valI)", forState: UIControlState.Normal)
                            prompt.iPhoneMessageButton.transform = CGAffineTransformMakeTranslation(60, 0)
                            prompt.iPhoneMessageButton.hidden = false
                            prompt.emailButton.transform = CGAffineTransformMakeTranslation(120, 0)
                        }
                        if let valM = phone["mobile"] {
                            prompt.mobileIncluded = true
                            profilePhone = "mobile : \(valM)"
                            prompt.enableMobileButtonOnPrompt()
                            prompt.mobileCallButton.setTitle("\(valM)", forState: UIControlState.Normal)
                            prompt.mobileCallButton.hidden = false
                            prompt.messageButton.setTitle("\(valM)", forState: UIControlState.Normal)
                            prompt.messageButton.transform = CGAffineTransformMakeTranslation(60, 0)
                            prompt.messageButton.hidden = false
                            prompt.emailButton.transform = CGAffineTransformMakeTranslation(120, 0)
                        if prompt.iPhoneIncluded {
                            let valI = phone["iPhone"]
                            profilePhone = "iPhone : \(valI)"
                            prompt.mobileCallButton.setTitle("\(valM)", forState: UIControlState.Normal)
                            prompt.mobileCallButton.transform = CGAffineTransformMakeTranslation(120, 0)
                            prompt.mobileCallButton.hidden = false
                            prompt.messageButton.setTitle("\(valM)", forState: UIControlState.Normal)
                            prompt.messageButton.transform = CGAffineTransformMakeTranslation(180, 0)
                            prompt.messageButton.hidden = false
                            prompt.emailButton.transform = CGAffineTransformMakeTranslation(240, 0)
                        }
                    }
                }
            }
            
            var emailsRef: ABMultiValueRef! = ABRecordCopyValue(record, kABPersonEmailProperty).takeRetainedValue() as ABMultiValueRef!
            if (emailsRef != nil)  {
                var emailNumberCount = ABMultiValueGetCount(emailsRef)
                for var j:Int = 0; j < emailNumberCount; j++ {
                    if (ABMultiValueCopyLabelAtIndex(emailsRef, j) != nil) {
                        var label: String = ABMultiValueCopyLabelAtIndex(emailsRef, j).takeRetainedValue() as NSString as! String
                        var email: String = ABMultiValueCopyValueAtIndex(emailsRef, j).takeRetainedValue() as! NSString as String
                        var localLabel: String = ABAddressBookCopyLocalizedLabel( label ).takeRetainedValue() as NSString as! String
                        localLabel.capitalizedString
                        
                        var localEmail = [localLabel: email]
                        emailsArray.append(localEmail)
                        promptEmailsArray.append(localEmail)
                    } else {
                        var label: String = "email "
                        var email: String = ABMultiValueCopyValueAtIndex(emailsRef, j).takeRetainedValue() as! NSString as String
                        var localEmail = [label: email]
                        emailsArray.append(localEmail)
                        promptEmailsArray.append(localEmail)
                    }
                }
                prompt.emailIncluded = true
                for email in promptEmailsArray {
                    // Grab each key, value pair from the person dictionary
                    for (key,value) in email {
                        if (emailsArray.count == 1) {
                            prompt.enableEmailButtonOnPrompt()
                            profileEmail = "\(value)"
                            prompt.emailButton.setTitle("\(value)", forState: UIControlState.Normal)
                            prompt.emailButton.hidden = false
                        } else if (emailsArray.count > 1) {
                            prompt.enableEmailButtonOnPrompt()
                            prompt.emailButton.setTitle("\(value)", forState: UIControlState.Normal)
                            prompt.emailButton.hidden = false
                            prompt.enableSecondEmailButtonOnPrompt()
                            prompt.secondEmailButton.setTitle("\(email)", forState: UIControlState.Normal)
                            prompt.secondEmailButton.hidden = false
                        }
                    }
                }
                if (profilePhone.isEmpty) {
                    profilePhone = profileEmail
                }
                if prompt.mobileIncluded || prompt.iPhoneIncluded {
                    prompt.secondEmailButton.transform = CGAffineTransformMakeTranslation(secondaryTranslate + 60, 0)
                } else {
                    prompt.secondEmailButton.transform = CGAffineTransformMakeTranslation(secondaryTranslate, 0)
                }
            }
            var jobTitle: String? = indexedPeople[indexPath.row]["JobTitle"] as! String?
            pickedTitle = jobTitle!
        }
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        pickedImage!.drawInRect(CGRect(origin: CGPointZero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Set the properties of the promt
        prompt.setPromtHeader(pickedName!)
        prompt.setPromptHeaderTxtSize(18.0)
        prompt.setPromptContentTxtSize(16.0)
        prompt.setPromptContentTxtColor(UIColor.whiteColor())
        prompt.setPromptContentText(profilePhone)
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
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    func clickedOnTheMainButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("profileViewController") as! ProfileViewController
        
        vc.image = pickedImage
        vc.imageBG = pickedBG
        vc.nameLabel = pickedName
        vc.coLabel = pickedCompany
        vc.jobTitleLabel = pickedTitle
        
        dispatch_async(dispatch_get_main_queue()) {
            self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            self.view.window!.rootViewController!.presentViewController(vc, animated: true, completion: nil)
            self.prompt.dismissPrompt()
            phonesArray.removeAll(keepCapacity: false)
            emailsArray.removeAll(keepCapacity: false)
            promptPhonesArray.removeAll(keepCapacity: false)
            promptEmailsArray.removeAll(keepCapacity: false)
        }
    }
    
    func clickedOnTheSecondButton() {
        println("Clicked on the second button")
        prompt.dismissPrompt()
        phonesArray.removeAll(keepCapacity: false)
        emailsArray.removeAll(keepCapacity: false)
        promptPhonesArray.removeAll(keepCapacity: false)
        promptEmailsArray.removeAll(keepCapacity: false)
    }
    
    func promptWasDismissed() {
        println("Dismissed the prompt")
    }
}

extension GridViewController: UISearchResultsUpdating
{
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        self.searchArray.removeAll(keepCapacity: false)
        
        var filteredArray = indexedPeople.filter() {m in
            let flName = (m as AnyObject!)["fullName"] as? String
            let lfName = (m as AnyObject!)["fullNameRev"] as? String
            return flName?.rangeOfString(searchController.searchBar.text, options: NSStringCompareOptions.AnchoredSearch) != nil || lfName?.rangeOfString(searchController.searchBar.text, options: NSStringCompareOptions.AnchoredSearch) != nil
        }
        self.searchArray = filteredArray
    }
}
