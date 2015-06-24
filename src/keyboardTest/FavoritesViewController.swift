//
//  FavoritesViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/11/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit
import Foundation
import AddressBook
import APAddressBook
import PKHUD

var pickedImage : UIImage!
var pickedBG : UIImage!
var pickedName : String?
var pickedCompany : String?
var pickedTitle : String?
var myResults: [AnyObject] = []
var objectKeys = [AnyObject]()
var indexedPeople = Array<Dictionary<String,AnyObject>>()
var myBook = Array<Dictionary<String,AnyObject>>()
var lookupController : KannuuIndexController? = nil
var phonesArray = Array<Dictionary<String,String>>()
var emailsArray = Array<Dictionary<String,String>>()
var localLabelArray = Array<Dictionary<String,String>>()
//
// util function to delay code exection by given interval
//
func mydelay(#seconds:Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
        completion()
    }
}

typealias CompletionOrNil = (() -> ())?

@objc
class FavoritesViewController: UITableViewController, UITextFieldDelegate, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var currentController: UIViewController?
    var parentNavigationController : UINavigationController?
    var textFieldInsideSearchBar = contactsSearchController.searchBar.valueForKey("searchField") as? UITextField
    var textField = normalSearchController.searchBar.valueForKey("searchField") as? UITextField
    
    var searchArray = Array<Dictionary<String,AnyObject>>(){
        didSet  {
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    func queueFunctions() {
        let masterQueue = TaskQueue()
        
        masterQueue.tasks += {
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: "Building Index…")
            PKHUD.sharedHUD.show()
            println("start master queue");
        }
        
        //define nested queue
        let nestedQueue = TaskQueue()
        nestedQueue.tasks += {_, next in
            myBook = self.getSysContacts()
            var error:Unmanaged<CFError>?
            mydelay(seconds: 0.0) {
                next(nil)
            }
        }
        nestedQueue.tasks += {_, next in
            self.createIndex()
            mydelay(seconds: 0.0) {
                next(nil)
            }
        }
        nestedQueue.tasks += {_, next in
            self.indexSorted()
            mydelay(seconds: 0.0) {
                next(nil)
            }
        }
        nestedQueue.completions.append({_ in
            println("completed nested queue")
        })
        //end of nested queue
        
        masterQueue.tasks += nestedQueue
        
        masterQueue.tasks += {
            println("back to master queue");
        }
        
        masterQueue.run {_ in
            self.tableView.reloadData()
            println("completed master queue");
            PKHUD.sharedHUD.hide()
        }
    }
    
    let ap = APAddressBook()
    var addressBook:ABAddressBookRef?
    
    func getSysContacts() -> [[String:AnyObject]] {
        let sysAddressBookStatus = ABAddressBookGetAuthorizationStatus()
        var error:Unmanaged<CFError>?
        addressBook = ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue()
        
        if sysAddressBookStatus == .Denied || sysAddressBookStatus == .NotDetermined {
            // Need to ask for authorization
            var authorizedSignal:dispatch_semaphore_t = dispatch_semaphore_create(0)
            var askAuthorization:ABAddressBookRequestAccessCompletionHandler = { success, error in
                if success {
                    ABAddressBookCopyArrayOfAllPeople(self.addressBook).takeRetainedValue() as NSArray
                    dispatch_semaphore_signal(authorizedSignal)
                }
            }
            ABAddressBookRequestAccessWithCompletion(addressBook, askAuthorization)
            dispatch_semaphore_wait(authorizedSignal, DISPATCH_TIME_FOREVER)
        }
        
        func analyzeSysContacts(sysContacts:NSArray) -> [[String:AnyObject]] {
            var allContacts:Array = [[String:AnyObject]]()
            
            func analyzeContactProperty(contact:ABRecordRef, property:ABPropertyID) -> [AnyObject]? {
                var propertyValues:ABMultiValueRef? = ABRecordCopyValue(contact, property)?.takeRetainedValue()
                if propertyValues != nil {
                    var values:Array<AnyObject> = Array()
                    for i in 0 ..< ABMultiValueGetCount(propertyValues) {
                        var value = ABMultiValueCopyValueAtIndex(propertyValues, i)
                        switch property {
                            
                        case kABPersonAddressProperty :
                            var valueDictionary:Dictionary = [String:String]()
                            
                            var addrNSDict:NSMutableDictionary = (value.takeRetainedValue() as? NSMutableDictionary)!
                            valueDictionary["_Country"] = addrNSDict.valueForKey(kABPersonAddressCountryKey as! String) as? String ?? ""
                            valueDictionary["_State"] = addrNSDict.valueForKey(kABPersonAddressStateKey as! String) as? String ?? ""
                            valueDictionary["_City"] = addrNSDict.valueForKey(kABPersonAddressCityKey as! String) as? String ?? ""
                            valueDictionary["_Street"] = addrNSDict.valueForKey(kABPersonAddressStreetKey as! String) as? String ?? ""
                            valueDictionary["_Countrycode"] = addrNSDict.valueForKey(kABPersonAddressCountryCodeKey as! String) as? String ?? ""
                            
                            
                            var fullAddress:String = (valueDictionary["_Country"]! == "" ? valueDictionary["_Countrycode"]! : valueDictionary["_Country"]!) + ", " + valueDictionary["_State"]! + ", " + valueDictionary["_City"]! + ", " + valueDictionary["_Street"]!
                            values.append(fullAddress)
                            
                        case kABPersonSocialProfileProperty :
                            var valueDictionary:Dictionary = [String:String]()
                            
                            var snsNSDict:NSMutableDictionary = (value.takeRetainedValue() as? NSMutableDictionary)!
                            valueDictionary["_Username"] = snsNSDict.valueForKey(kABPersonSocialProfileUsernameKey as! String) as? String ?? ""
                            valueDictionary["_URL"] = snsNSDict.valueForKey(kABPersonSocialProfileURLKey as! String) as? String ?? ""
                            valueDictionary["_Serves"] = snsNSDict.valueForKey(kABPersonSocialProfileServiceKey as! String) as? String ?? ""
                            
                            values.append(valueDictionary)
                            
                        case kABPersonInstantMessageProperty :
                            var valueDictionary:Dictionary = [String:String]()
                            
                            var imNSDict:NSMutableDictionary = (value.takeRetainedValue() as? NSMutableDictionary)!
                            valueDictionary["_Serves"] = imNSDict.valueForKey(kABPersonInstantMessageServiceKey as! String) as? String ?? ""
                            valueDictionary["_Username"] = imNSDict.valueForKey(kABPersonInstantMessageUsernameKey as! String) as? String ?? ""
                            
                            values.append(valueDictionary)
                            
                        case kABPersonDateProperty :
                            var date:String? = (value.takeRetainedValue() as? NSDate)?.description
                            if date != nil {
                                values.append(date!)
                            }
                        default :
                            var val:String = value.takeRetainedValue() as? String ?? ""
                            values.append(val)
                        }
                    }
                    return values
                }else{
                    return nil
                }
            }
            
            for contact in sysContacts {
                var currentContact:Dictionary = [String:AnyObject]()
                currentContact["abrecord"] = contact
                
                var FirstName:String = ABRecordCopyValue(contact, kABPersonFirstNameProperty)?.takeRetainedValue() as? String ?? ""
                currentContact["FirstName"] = FirstName
                currentContact["FirstNamePhonetic"] = ABRecordCopyValue(contact, kABPersonFirstNamePhoneticProperty)?.takeRetainedValue() as? String ?? ""
                
                var LastName:String = ABRecordCopyValue(contact, kABPersonLastNameProperty)?.takeRetainedValue() as? String ?? ""
                currentContact["LastName"] = LastName
                currentContact["LastNamePhonetic"] = ABRecordCopyValue(contact, kABPersonLastNamePhoneticProperty)?.takeRetainedValue() as? String ?? ""
                
                currentContact["Nickname"] = ABRecordCopyValue(contact, kABPersonNicknameProperty)?.takeRetainedValue() as? String ?? ""
                
                currentContact["fullName"] = FirstName + " " + LastName
                
                currentContact["fullNameRev"] = LastName + " " + FirstName
                
                currentContact["Organization"] = ABRecordCopyValue(contact, kABPersonOrganizationProperty)?.takeRetainedValue() as? String ?? ""
                
                currentContact["JobTitle"] = ABRecordCopyValue(contact, kABPersonJobTitleProperty)?.takeRetainedValue() as? String ?? ""
                
                currentContact["Department"] = ABRecordCopyValue(contact, kABPersonDepartmentProperty)?.takeRetainedValue() as? String ?? ""
                
                currentContact["Note"] = ABRecordCopyValue(contact, kABPersonNoteProperty)?.takeRetainedValue() as? String ?? ""
                
                var Phone:Array<AnyObject>? = analyzeContactProperty(contact, kABPersonPhoneProperty)
                if Phone != nil {
                    currentContact["Phone"] = Phone
                }
                
                var Address:Array<AnyObject>? = analyzeContactProperty(contact, kABPersonAddressProperty)
                if Address != nil {
                    currentContact["Address"] = Address
                }
                
                var Email:Array<AnyObject>? = analyzeContactProperty(contact, kABPersonEmailProperty)
                if Email != nil {
                    currentContact["Email"] = Email
                }
                
                var Date:Array<AnyObject>? = analyzeContactProperty(contact, kABPersonDateProperty)
                if Date != nil {
                    currentContact["Date"] = Date
                }
                
                var URL:Array<AnyObject>? = analyzeContactProperty(contact, kABPersonURLProperty)
                if URL != nil{
                    currentContact["URL"] = URL
                }
                
                var SNS:Array<AnyObject>? = analyzeContactProperty(contact, kABPersonSocialProfileProperty)
                if SNS != nil {
                    currentContact["SNS"] = SNS
                }
                
                if ABPersonHasImageData(contact){
                    let fullData = ABPersonCopyImageDataWithFormat(contact, kABPersonImageFormatOriginalSize).takeRetainedValue() as NSData
                    let data = ABPersonCopyImageDataWithFormat(contact, kABPersonImageFormatThumbnail).takeRetainedValue() as NSData
                    currentContact["FullImage"] = UIImage(data: data)
                    currentContact["Thumbnail"] = UIImage(data: data)
                } else {
                    currentContact["FullImage"] = UIImage(named: "placeBG")
                    currentContact["Thumbnail"] = UIImage(named: "placeholder")
                }
                allContacts.append(currentContact)
            }
            allContacts = sorted(allContacts,mcp)
            return allContacts
        }
        return analyzeSysContacts( ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        self.tableView!.backgroundColor = UIColor.clearColor()
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView!.registerClass(FriendTableViewCell.self, forCellReuseIdentifier: "FriendTableViewCell")
        self.tableView!.bounds = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        self.queueFunctions()
        scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
    }
    
    func mcp(dict1: Dictionary<String,AnyObject>, dict2:Dictionary<String,AnyObject>) -> Bool{
        
        let firstname1 = dict1["FirstName"] as! String
        let firstname2 = dict2["FirstName"] as! String
        let lastname1 = dict1["LastName"] as! String
        let lastname2 = dict2["LastName"] as! String
        if firstname1 == firstname2 {
            return lastname1 < lastname2
        } else {
            return firstname1 < firstname2
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView!.showsVerticalScrollIndicator = true
        self.tableView!.delaysContentTouches = false
        contactsSearchController.searchResultsUpdater = self
        normalSearchController.searchResultsUpdater = self
        
        textFieldInsideSearchBar?.textColor = UIColor.whiteColor()
        textFieldInsideSearchBar?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if contactsSearchController.active {
            controller.view.hidden = true
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(false)
        super.touchesBegan(touches as Set<NSObject>, withEvent: event)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }
    
    func test() {
        
        self.ap.loadContacts(
            { (contacts: [AnyObject]!, error: NSError!) in
                if contacts != nil{
                    for contact in contacts {
                        let c = contact as! APContact
                        println(c.firstName)
                    }
                }
                else if error != nil {
                     println("error")
                }
        })
    }

    func createIndex() {
        let dataItems = myBook
        let indexFilePath = self.indexFile
        var indexController = KannuuIndexController(controllerMode: .Create, indexFilePath: indexFilePath, numberOfOptions: 9, numberOfBranchSelections: 999)
        for dictionary in dataItems {
            if (dictionary["fullName"] != nil) {
                let flName = (dictionary["FirstName"]! as! String) + " " + (dictionary["LastName"]! as! String)
                let lfName = (dictionary["LastName"]! as! String) + " " + (dictionary["FirstName"]! as! String)
                var error : NSError? = nil
                indexController?.addIndicies([flName], forData: flName, priority: 0, error: &error)
                indexController?.addIndicies([lfName], forData: flName, priority: 1, error: &error)
            }
        }
        indexController = nil
        lookupController = KannuuIndexController(controllerMode: .Lookup, indexFilePath: indexFilePath, numberOfOptions: 9, numberOfBranchSelections: 999)
        objectKeys = lookupController!.options!
        let selections = lookupController!.branchSelecions!
        myResults += selections
    }
    
    func indexSorted() {
        var filteredArray = Array<[String: AnyObject]>()
        if (indexedPeople.count == 0) {
            for names in myResults {
                var name: Int = 0
                filteredArray = myBook.filter() {
                    if let type = ($0 as AnyObject!)["fullName"] as? String {
                        return type.rangeOfString(names as! String, options: NSStringCompareOptions.LiteralSearch) != nil
                    } else {
                        return false
                    }
                }
                indexedPeople.insert(filteredArray[0], atIndex: name)
            }
            indexedPeople = indexedPeople.reverse()
        } else {
            return
        }
    }
    
    internal var documentsDirectory : String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as! [String]
        return paths.first!
    }
    
    internal var indexFile : String {
        return self.documentsDirectory.stringByAppendingPathComponent("ABSample")
    }
}
