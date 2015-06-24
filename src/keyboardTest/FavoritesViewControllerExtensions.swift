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
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (contactsSearchController.active || normalSearchController.active)
        {
            return searchArray.count
        } else
        {
            return indexedPeople.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var record: ABRecordRef! = nil
        
        let cellIdentifier:String = "FriendTableViewCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FriendTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.homeCallBtn.hidden = true
        cell.homeCallBtn.setTitle("", forState: UIControlState.Normal)
        cell.workCallBtn.hidden = true
        cell.workCallBtn.setTitle("", forState: UIControlState.Normal)
        cell.mobileCallBtn.hidden = true
        cell.mobileCallBtn.setTitle("", forState: UIControlState.Normal)
        cell.mobileTxtBtn.hidden = true
        cell.mobileTxtBtn.setTitle("", forState: UIControlState.Normal)
        cell.iPhoneCallBtn.hidden = true
        cell.iPhoneCallBtn.setTitle("", forState: UIControlState.Normal)
        cell.iPhoneTxtBtn.hidden = true
        cell.iPhoneTxtBtn.setTitle("", forState: UIControlState.Normal)
        cell.emailBtn.hidden = true
        cell.emailBtn.setTitle("", forState: UIControlState.Normal)
        cell.secondaryEmailBtn.hidden = true
        cell.secondaryEmailBtn.setTitle("", forState: UIControlState.Normal)
        cell.workCallBtn.transform = CGAffineTransformMakeTranslation(0, 0)
        cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(0, 0)
        cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(0, 0)
        cell.iPhoneCallBtn.transform = CGAffineTransformMakeTranslation(0, 0)
        cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(0, 0)
        cell.emailBtn.transform = CGAffineTransformMakeTranslation(0, 0)
        cell.secondaryEmailBtn.transform = CGAffineTransformMakeTranslation(0, 0)
        localLabelArray.removeAll(keepCapacity: false)
        var mobileIncluded: Bool = false
        var workIncluded: Bool = false
        var homeIncluded: Bool = false
        var iPhoneIncluded: Bool = false
        
            if (contactsSearchController.active || normalSearchController.active)
            {
                record = self.searchArray[indexPath.row]["abrecord"] as ABRecordRef!
                cell.photoImageView!.image = self.searchArray[indexPath.row]["Thumbnail"] as? UIImage
                cell.nameLabel!.text = self.searchArray[indexPath.row]["fullName"] as? String
                var phonesRef: ABMultiValueRef! = ABRecordCopyValue(record, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef!
                var phoneNumberCount: Int = ABMultiValueGetCount(phonesRef)
                var secondaryTranslate: CGFloat = 60 * CGFloat(phoneNumberCount+1)
                
                if (phonesRef != nil)  {
                    for var i:Int = 0; i < phoneNumberCount; i++ {
                        if (ABMultiValueCopyLabelAtIndex(phonesRef, i) != nil) {
                            var label: String = ABMultiValueCopyLabelAtIndex(phonesRef, i).takeRetainedValue() as NSString as! String
                            var phone: String = ABMultiValueCopyValueAtIndex(phonesRef, i).takeRetainedValue() as! NSString as String
                            var localLabel: String = ABAddressBookCopyLocalizedLabel( label ).takeRetainedValue() as NSString as! String
                            localLabel.capitalizedString
                            
                            var labelArray = [localLabel:phone]
                            localLabelArray.append(labelArray)
                        }
                    }
                    for phone in localLabelArray {
                        if let valI = phone["iPhone"] {
                            iPhoneIncluded = true
                            cell.iPhoneCallBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                            cell.iPhoneCallBtn.hidden = false
                            cell.iPhoneTxtBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                            cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                            cell.iPhoneTxtBtn.hidden = false
                            cell.emailBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                        }
                        if let valM = phone["mobile"] {
                            mobileIncluded = true
                            cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                            cell.mobileCallBtn.hidden = false
                            cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                            cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                            cell.mobileTxtBtn.hidden = false
                            cell.emailBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                            if iPhoneIncluded {
                                cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.mobileCallBtn.hidden = false
                                cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                                cell.mobileTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(240, 0)
                            }
                        }
                        if let valW = phone["work"] {
                            workIncluded = true
                            cell.workCallBtn.setTitle("\(valW)", forState: UIControlState.Normal)
                            cell.workCallBtn.hidden = false
                            cell.emailBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                            if iPhoneIncluded && !mobileIncluded {
                                let valI = phone["iPhone"]
                                cell.iPhoneCallBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.iPhoneCallBtn.hidden = false
                                cell.iPhoneTxtBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.iPhoneTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                            }
                            if mobileIncluded && !iPhoneIncluded {
                                let valM = phone["mobile"]
                                cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.mobileCallBtn.hidden = false
                                cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.mobileTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                            }
                            if mobileIncluded && iPhoneIncluded {
                                let valM = phone["mobile"]
                                let valI = phone["iPhone"]
                                cell.iPhoneCallBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.iPhoneCallBtn.hidden = false
                                cell.iPhoneTxtBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.iPhoneTxtBtn.hidden = false
                                
                                cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                                cell.mobileCallBtn.hidden = false
                                cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(240, 0)
                                cell.mobileTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(300, 0)
                            }
                        }
                        if let valH = phone["home"] {
                            homeIncluded = true
                            cell.homeCallBtn.setTitle("\(valH)", forState: UIControlState.Normal)
                            cell.homeCallBtn.hidden = false
                            cell.emailBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                            if workIncluded && !mobileIncluded && !iPhoneIncluded {
                                let valW = phone["work"]
                                cell.workCallBtn.setTitle("\(valW)", forState: UIControlState.Normal)
                                cell.workCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.workCallBtn.hidden = false
                            }
                            if workIncluded && mobileIncluded && !iPhoneIncluded {
                                let valW = phone["work"]
                                let valM = phone["mobile"]
                                cell.workCallBtn.setTitle("\(valW)", forState: UIControlState.Normal)
                                cell.workCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.workCallBtn.hidden = false
                                cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.mobileCallBtn.hidden = false
                                cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                                cell.mobileTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(240, 0)
                            }
                            if workIncluded && !mobileIncluded && iPhoneIncluded {
                                let valW = phone["work"]
                                let valI = phone["iPhone"]
                                cell.workCallBtn.setTitle("\(valW)", forState: UIControlState.Normal)
                                cell.workCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.workCallBtn.hidden = false
                                cell.iPhoneCallBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneCallBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.iPhoneCallBtn.hidden = false
                                cell.iPhoneTxtBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                                cell.iPhoneTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(240, 0)
                            }
                            if workIncluded && mobileIncluded && iPhoneIncluded {
                                let valW = phone["work"]
                                let valI = phone["iPhone"]
                                let valM = phone["mobile"]
                                cell.workCallBtn.setTitle("\(valW)", forState: UIControlState.Normal)
                                cell.workCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.workCallBtn.hidden = false
                                cell.iPhoneCallBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneCallBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.iPhoneCallBtn.hidden = false
                                cell.iPhoneTxtBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                                cell.iPhoneTxtBtn.hidden = false
                                cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(240, 0)
                                cell.mobileCallBtn.hidden = false
                                cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(300, 0)
                                cell.mobileTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(300, 0)
                            }
                        }
                    }
                }
                
                var emailsRef: ABMultiValueRef! = ABRecordCopyValue(record, kABPersonEmailProperty).takeRetainedValue() as ABMultiValueRef!
                if (emailsRef != nil)  {
                    var emailNumberCount = ABMultiValueGetCount(emailsRef)
                    for var j:Int = 0; j < emailNumberCount; j++ {
                        var email: String = ABMultiValueCopyValueAtIndex(emailsRef, j).takeRetainedValue() as! NSString as String
                        if (emailNumberCount > 0 && emailNumberCount == 1) {
                            cell.emailBtn.setTitle("\(email)", forState: UIControlState.Normal)
                            cell.emailBtn.hidden = false
                        }
                        if (emailNumberCount > 1) {
                            if (j == 0) {
                                cell.emailBtn.setTitle("\(email)", forState: UIControlState.Normal)
                                cell.emailBtn.hidden = false
                            } else {
                                cell.secondaryEmailBtn.setTitle("\(email)", forState: UIControlState.Normal)
                                cell.secondaryEmailBtn.hidden = false
                                cell.configureSecondaryBtns()
                                if mobileIncluded || iPhoneIncluded {
                                    cell.secondaryEmailBtn.transform = CGAffineTransformMakeTranslation(secondaryTranslate + 60, 0)
                                } else {
                                    cell.secondaryEmailBtn.transform = CGAffineTransformMakeTranslation(secondaryTranslate, 0)
                                }
                                if (secondaryTranslate == 0) {
                                    cell.secondaryEmailBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                }
                            }
                        }
                    }
                }
                return cell
            }
            
            else
            {
                record = indexedPeople[indexPath.row]["abrecord"] as ABRecordRef!
                cell.photoImageView!.image = indexedPeople[indexPath.row]["Thumbnail"] as? UIImage
                cell.nameLabel!.text = indexedPeople[indexPath.row]["fullName"] as? String
                
                var phonesRef: ABMultiValueRef! = ABRecordCopyValue(record, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef!
                var phoneNumberCount: Int = ABMultiValueGetCount(phonesRef)
                var secondaryTranslate: CGFloat = 60 * CGFloat(phoneNumberCount+1)
                
                if (phonesRef != nil)  {
                    for var i:Int = 0; i < phoneNumberCount; i++ {
                        if (ABMultiValueCopyLabelAtIndex(phonesRef, i) != nil) {
                            var label: String = ABMultiValueCopyLabelAtIndex(phonesRef, i).takeRetainedValue() as NSString as! String
                            var phone: String = ABMultiValueCopyValueAtIndex(phonesRef, i).takeRetainedValue() as! NSString as String
                            var localLabel: String = ABAddressBookCopyLocalizedLabel( label ).takeRetainedValue() as NSString as! String
                            localLabel.capitalizedString
                            
                            var labelArray = [localLabel:phone]
                            localLabelArray.append(labelArray)
                        }
                    }
                    for phone in localLabelArray {
                        if let valI = phone["iPhone"] {
                            iPhoneIncluded = true
                            cell.iPhoneCallBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                            cell.iPhoneCallBtn.hidden = false
                            cell.iPhoneTxtBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                            cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                            cell.iPhoneTxtBtn.hidden = false
                            cell.emailBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                        }
                        if let valM = phone["mobile"] {
                            mobileIncluded = true
                            cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                            cell.mobileCallBtn.hidden = false
                            cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                            cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                            cell.mobileTxtBtn.hidden = false
                            cell.emailBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                            if iPhoneIncluded {
                                cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.mobileCallBtn.hidden = false
                                cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                                cell.mobileTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(240, 0)
                            }
                        }
                        if let valW = phone["work"] {
                            workIncluded = true
                            cell.workCallBtn.setTitle("\(valW)", forState: UIControlState.Normal)
                            cell.workCallBtn.hidden = false
                            cell.emailBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                            if iPhoneIncluded && !mobileIncluded {
                                let valI = phone["iPhone"]
                                cell.iPhoneCallBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.iPhoneCallBtn.hidden = false
                                cell.iPhoneTxtBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.iPhoneTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                            }
                            if mobileIncluded && !iPhoneIncluded {
                                let valM = phone["mobile"]
                                cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.mobileCallBtn.hidden = false
                                cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.mobileTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                            }
                            if mobileIncluded && iPhoneIncluded {
                                let valM = phone["mobile"]
                                let valI = phone["iPhone"]
                                cell.iPhoneCallBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.iPhoneCallBtn.hidden = false
                                cell.iPhoneTxtBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.iPhoneTxtBtn.hidden = false

                                cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                                cell.mobileCallBtn.hidden = false
                                cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(240, 0)
                                cell.mobileTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(300, 0)
                            }
                        }
                        if let valH = phone["home"] {
                            homeIncluded = true
                            cell.homeCallBtn.setTitle("\(valH)", forState: UIControlState.Normal)
                            cell.homeCallBtn.hidden = false
                            cell.emailBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                            if workIncluded && !mobileIncluded && !iPhoneIncluded {
                                let valW = phone["work"]
                                cell.workCallBtn.setTitle("\(valW)", forState: UIControlState.Normal)
                                cell.workCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.workCallBtn.hidden = false
                            }
                            if workIncluded && mobileIncluded && !iPhoneIncluded {
                                let valW = phone["work"]
                                let valM = phone["mobile"]
                                cell.workCallBtn.setTitle("\(valW)", forState: UIControlState.Normal)
                                cell.workCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.workCallBtn.hidden = false
                                cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.mobileCallBtn.hidden = false
                                cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                                cell.mobileTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(240, 0)
                            }
                            if workIncluded && !mobileIncluded && iPhoneIncluded {
                                let valW = phone["work"]
                                let valI = phone["iPhone"]
                                cell.workCallBtn.setTitle("\(valW)", forState: UIControlState.Normal)
                                cell.workCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.workCallBtn.hidden = false
                                cell.iPhoneCallBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneCallBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.iPhoneCallBtn.hidden = false
                                cell.iPhoneTxtBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                                cell.iPhoneTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(240, 0)
                            }
                            if workIncluded && mobileIncluded && iPhoneIncluded {
                                let valW = phone["work"]
                                let valI = phone["iPhone"]
                                let valM = phone["mobile"]
                                cell.workCallBtn.setTitle("\(valW)", forState: UIControlState.Normal)
                                cell.workCallBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                cell.workCallBtn.hidden = false
                                cell.iPhoneCallBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneCallBtn.transform = CGAffineTransformMakeTranslation(120, 0)
                                cell.iPhoneCallBtn.hidden = false
                                cell.iPhoneTxtBtn.setTitle("\(valI)", forState: UIControlState.Normal)
                                cell.iPhoneTxtBtn.transform = CGAffineTransformMakeTranslation(180, 0)
                                cell.iPhoneTxtBtn.hidden = false
                                cell.mobileCallBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileCallBtn.transform = CGAffineTransformMakeTranslation(240, 0)
                                cell.mobileCallBtn.hidden = false
                                cell.mobileTxtBtn.setTitle("\(valM)", forState: UIControlState.Normal)
                                cell.mobileTxtBtn.transform = CGAffineTransformMakeTranslation(300, 0)
                                cell.mobileTxtBtn.hidden = false
                                cell.emailBtn.transform = CGAffineTransformMakeTranslation(300, 0)
                            }
                        }
                    }
                }
                
                var emailsRef: ABMultiValueRef! = ABRecordCopyValue(record, kABPersonEmailProperty).takeRetainedValue() as ABMultiValueRef!
                if (emailsRef != nil)  {
                    var emailNumberCount = ABMultiValueGetCount(emailsRef)
                    for var j:Int = 0; j < emailNumberCount; j++ {
                        var email: String = ABMultiValueCopyValueAtIndex(emailsRef, j).takeRetainedValue() as! NSString as String
                        if (emailNumberCount > 0 && emailNumberCount == 1) {
                            cell.emailBtn.setTitle("\(email)", forState: UIControlState.Normal)
                            cell.emailBtn.hidden = false
                        }
                        if (emailNumberCount > 1) {
                            if (j == 0) {
                                cell.emailBtn.setTitle("\(email)", forState: UIControlState.Normal)
                                cell.emailBtn.hidden = false
                            } else {
                                cell.secondaryEmailBtn.setTitle("\(email)", forState: UIControlState.Normal)
                                cell.secondaryEmailBtn.hidden = false
                                cell.configureSecondaryBtns()
                                if mobileIncluded {
                                    cell.secondaryEmailBtn.transform = CGAffineTransformMakeTranslation(secondaryTranslate + 60, 0)
                                } else {
                                    cell.secondaryEmailBtn.transform = CGAffineTransformMakeTranslation(secondaryTranslate, 0)
                                }
                                if (secondaryTranslate == 0) {
                                    cell.secondaryEmailBtn.transform = CGAffineTransformMakeTranslation(60, 0)
                                }
                            }
                        }
                    }
                }
                return cell
            }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 74.0
    }
}

extension FavoritesViewController: UITableViewDelegate
{
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var record: ABRecordRef!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("profileViewController") as! ProfileViewController
        
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
            
            var company: String? = self.searchArray[indexPath.row]["Organization"] as! String?
            pickedCompany = company
            
            var jobTitle: String? = self.searchArray[indexPath.row]["JobTitle"] as! String?
            pickedTitle = jobTitle!
        }
        
        else
        {
            record = indexedPeople[indexPath.row]["abrecord"] as ABRecordRef!
            
            var name: String? = indexedPeople[indexPath.row]["fullName"] as! String?
            recentPeople.append(name!)
            pickedName = name
            
            var image: UIImage! = indexedPeople[indexPath.row]["Thumbnail"] as! UIImage!
            var imageBG: UIImage! = indexedPeople[indexPath.row]["FullImage"] as! UIImage!
            pickedBG = imageBG
            pickedImage = image
            
            var company: String? = indexedPeople[indexPath.row]["Organization"] as! String?
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
            var jobTitle: String? = indexedPeople[indexPath.row]["JobTitle"] as! String?
            pickedTitle = jobTitle!
        }
        
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

extension FavoritesViewController: UISearchResultsUpdating
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
