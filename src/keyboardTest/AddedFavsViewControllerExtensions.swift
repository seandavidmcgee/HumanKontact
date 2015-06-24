//
//  AddedFavsViewControllerExtensions.swift
//  keyboardTest
//
//  Created by Sean McGee on 6/12/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import Foundation
import UIKit

extension AddedFavsViewController: UITableViewDataSource
{
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return visibleArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = self.tableView!.dequeueReusableCellWithIdentifier("FriendTableViewCell") as! FriendTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None 
        
        cell.photoImageView!.image = visibleArray[indexPath.row]["Thumbnail"] as? UIImage
        cell.nameLabel!.text = visibleArray[indexPath.row]["fullName"] as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 74.0
    }
}

extension AddedFavsViewController: UITableViewDelegate
{
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var record: ABRecordRef!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("profileViewController") as! ProfileViewController
        
        record = visibleArray[indexPath.row]["abrecord"] as ABRecordRef!
        
        var name: String? = visibleArray[indexPath.row]["fullName"] as! String?
        recentPeople.append(name!)
        pickedName = name
        
        var image: UIImage! = visibleArray[indexPath.row]["Thumbnail"] as! UIImage!
        var imageBG: UIImage! = visibleArray[indexPath.row]["FullImage"] as! UIImage!
        pickedBG = imageBG
        pickedImage = image
        
        var company: String? = visibleArray[indexPath.row]["Organization"] as! String?
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
        var jobTitle: String? = visibleArray[indexPath.row]["JobTitle"] as! String?
        pickedTitle = "Job Title: " + jobTitle!
        
        vc.image = pickedImage
        vc.imageBG = pickedBG
        vc.nameLabel = pickedName
        vc.coLabel = pickedCompany
        vc.jobTitleLabel = pickedTitle
        
        self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        dispatch_async(dispatch_get_main_queue()) {
            self.view.window!.rootViewController!.presentViewController(vc, animated: true, completion: nil)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
