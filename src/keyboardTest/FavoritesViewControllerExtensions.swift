//
//  FavoritesViewControllerExtensions.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/21/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import Foundation
import UIKit

extension FavoritesViewController: UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (contactsSearchController.active)
        {
            return self.searchArray.count
        } else
        {
            return self.myBook.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = self.contactsTable.dequeueReusableCellWithIdentifier("FriendTableViewCell") as! FriendTableViewCell
        var quickactions = self.contactsTable.dequeueReusableCellWithIdentifier("ProfileMenuCell") as! ProfileMenuCell
        
        if (contactsSearchController.active)
        {
            cell.photoImageView!.image = self.searchArray[indexPath.row]["FullImage"] as? UIImage
            let firstName = self.searchArray[indexPath.row]["FirstName"] as? String
            let lastName = self.searchArray[indexPath.row]["LastName"] as? String
            cell.sourceLabel!.text = "Added from iPhone"
            cell.nameLabel!.text = (firstName ?? "") + " " + (lastName ?? "")
            return cell
        }
            
        else
        {
            cell.photoImageView!.image = self.myBook[indexPath.row]["FullImage"] as? UIImage
            let firstName = self.myBook[indexPath.row]["FirstName"] as? String
            let lastName = self.myBook[indexPath.row]["LastName"] as? String
            cell.sourceLabel!.text = "Added from iPhone"
            cell.nameLabel!.text = (firstName ?? "") + " " + (lastName ?? "")
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 47.0
    }
}

extension FavoritesViewController: UITableViewDelegate
{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var record: ABRecordRef!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("profileViewController") as! ProfileViewController
        
        if (contactsSearchController.active)
        {
            record = self.searchArray[indexPath.row]["abrecord"] as ABRecordRef!
            
            var name: String? = self.searchArray[indexPath.row]["fullName"] as! String?
            pickedName = name
            
            var image: UIImage! = self.searchArray[indexPath.row]["FullImage"] as! UIImage!
            pickedImage = image
            
            var company: String? = self.searchArray[indexPath.row]["Organization"] as! String?
            pickedCompany = company
            
            let unmanagedPhones = ABRecordCopyValue(record, kABPersonPhoneProperty)
            let phones: ABMultiValueRef = Unmanaged.fromOpaque(unmanagedPhones.toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef
            let countOfPhones = ABMultiValueGetCount(phones)
            
            for index in 0..<countOfPhones {
                let unmanagedPhone = ABMultiValueCopyValueAtIndex(phones, index)
                let phone: String = Unmanaged.fromOpaque(unmanagedPhone.toOpaque()).takeUnretainedValue() as NSObject as! String
                if (countOfPhones == 1) {
                    if (index == 0) {
                        pickedMobile = "Mobile: " + phone
                    }
                }
                if (countOfPhones == 2) {
                    if (index == 0) {
                        pickedHome = "Home: " + phone
                    }
                    if (index == 1) {
                        pickedMobile = "Mobile: " + phone
                    }
                }
            }
            
            let unmanagedEmails = ABRecordCopyValue(record, kABPersonEmailProperty)
            let emails: ABMultiValueRef = Unmanaged.fromOpaque(unmanagedEmails.toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef
            let countOfEmails = ABMultiValueGetCount(emails)
            
            for index in 0..<countOfEmails {
                let unmanagedEmail = ABMultiValueCopyValueAtIndex(emails, index)
                let email: String = Unmanaged.fromOpaque(unmanagedEmail.toOpaque()).takeUnretainedValue() as NSObject as! String
                if (index == 0) {
                    pickedEmail = "Work Email: " + email
                }
            }
            
            var jobTitle: String? = self.searchArray[indexPath.row]["JobTitle"] as! String?
            pickedTitle = "Job Title: " + jobTitle!
        }
        
        else
        {
            record = self.myBook[indexPath.row]["abrecord"] as ABRecordRef!
            
            var name: String? = self.myBook[indexPath.row]["fullName"] as! String?
            pickedName = name
            
            var image: UIImage! = self.myBook[indexPath.row]["FullImage"] as! UIImage!
            pickedImage = image
            
            var company: String? = self.myBook[indexPath.row]["Organization"] as! String?
            pickedCompany = company
            
            let unmanagedPhones = ABRecordCopyValue(record, kABPersonPhoneProperty)
            let phones: ABMultiValueRef = Unmanaged.fromOpaque(unmanagedPhones.toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef
            let countOfPhones = ABMultiValueGetCount(phones)
            
            for index in 0..<countOfPhones {
                let unmanagedPhone = ABMultiValueCopyValueAtIndex(phones, index)
                let phone: String = Unmanaged.fromOpaque(unmanagedPhone.toOpaque()).takeUnretainedValue() as NSObject as! String
                
                if (countOfPhones == 1) {
                    if (index == 0) {
                        pickedMobile = "Mobile: " + phone
                    }
                }
                if (countOfPhones == 2) {
                    if (index == 0) {
                        pickedHome = "Home: " + phone
                    }
                    if (index == 1) {
                        pickedMobile = "Mobile: " + phone
                    }
                }
            }
            
            let unmanagedEmails = ABRecordCopyValue(record, kABPersonEmailProperty)
            let emails: ABMultiValueRef = Unmanaged.fromOpaque(unmanagedEmails.toOpaque()).takeUnretainedValue() as NSObject as ABMultiValueRef
            let countOfEmails = ABMultiValueGetCount(emails)
            
            for index in 0..<countOfEmails {
                let unmanagedEmail = ABMultiValueCopyValueAtIndex(emails, index)
                let email: String = Unmanaged.fromOpaque(unmanagedEmail.toOpaque()).takeUnretainedValue() as NSObject as! String
                if (index == 0) {
                    pickedEmail = "Work Email: " + email
                }
            }
            
            var jobTitle: String? = self.myBook[indexPath.row]["JobTitle"] as! String?
            pickedTitle = "Job Title: " + jobTitle!
        }
        
        vc.image = pickedImage
        vc.nameLabel = pickedName
        vc.coLabel = pickedCompany
        vc.mobileLabel = pickedMobile
        vc.homeLabel = pickedHome
        vc.emailLabel = pickedEmail
        vc.jobTitleLabel = pickedTitle
        
        self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
            self.presentViewController(vc, animated: true, completion: nil)
        })
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

extension FavoritesViewController: UISearchResultsUpdating
{
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        self.searchArray.removeAll(keepCapacity: false)
        
        let filteredArray = myBook.filter() {
            if let type = ($0 as AnyObject!)["fullName"] as? String {
                return type.rangeOfString(searchController.searchBar.text, options: NSStringCompareOptions.LiteralSearch) != nil
            } else {
                return false
            }
        }
        self.searchArray = filteredArray
    }
}
