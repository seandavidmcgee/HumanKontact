//
//  GridViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/30/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit
import Foundation

var promptPhonesArray = Array<Dictionary<String,String>>()
var promptEmailsArray = Array<Dictionary<String,String>>()

class GridViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate, UIScrollViewDelegate, SwiftPromptsProtocol {
    
    var collectionView: UICollectionView?
    var scrollView: UIScrollView!
    var currentController: UICollectionViewController?
    var parentNavigationController : UINavigationController?
    var prompt = SwiftPromptsView()
    var textFieldInsideSearchBar = contactsSearchController.searchBar.valueForKey("searchField") as? UITextField
    var searchArray = Array<Dictionary<String,AnyObject>>(){
        didSet  {
            self.collectionView!.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 58, height: 102)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.registerClass(FriendCollectionViewCell.self, forCellWithReuseIdentifier: "FriendCollectionViewCell")
        collectionView!.backgroundColor = UIColor.clearColor()
        self.view.addSubview(collectionView!)
        scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView!.showsVerticalScrollIndicator = false
        collectionView!.showsVerticalScrollIndicator = true
        collectionView!.delaysContentTouches = false
        
        contactsSearchController.searchResultsUpdater = self
        normalSearchController.searchResultsUpdater = self
        
        textFieldInsideSearchBar?.textColor = UIColor.whiteColor()
        textFieldInsideSearchBar?.delegate = self
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(false)
        super.touchesBegan(touches as Set<NSObject>, withEvent: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }
}
