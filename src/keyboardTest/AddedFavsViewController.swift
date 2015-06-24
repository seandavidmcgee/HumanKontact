//
//  AddedFavsViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 6/12/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit
import Foundation

class AddedFavsViewController: UITableViewController, UITextFieldDelegate {
    var currentController: UIViewController?
    var parentNavigationController : UINavigationController?
    var filteredArray = Array<Dictionary<String,AnyObject>>()
    var visibleArray = Array<Dictionary<String,AnyObject>>(){
        didSet  {
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView!.reloadData()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.indexSorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        self.tableView!.backgroundColor = UIColor.clearColor()
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView!.registerClass(FriendTableViewCell.self, forCellReuseIdentifier: "FriendTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView!.showsVerticalScrollIndicator = true
        self.tableView!.delaysContentTouches = false
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        filteredArray.removeAll(keepCapacity: false)
        visibleArray.removeAll(keepCapacity: false)
    }
    
    func indexSorted() {
        if (favPeople.count > 0) {
            for names in favPeople {
                var name: Int = 0
                filteredArray = myBook.filter() {
                    if let type = ($0 as AnyObject!)["fullName"] as? String {
                        return type.rangeOfString(names as! String, options: NSStringCompareOptions.LiteralSearch) != nil
                    } else {
                        return false
                    }
                }
                visibleArray.insert(filteredArray[0], atIndex: name)
            }
        } else {
            return
        }
    }
}
