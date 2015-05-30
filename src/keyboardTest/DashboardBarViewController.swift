//
//  DashboardBarViewController.swift
//  keyboardTest
//
//  Created by Sean McGee on 5/29/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit

class DashboardBarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var profileImage = UIImage(named: "profile")
        var dashBG = UIImageView(frame: CGRectMake(0, view.frame.height - 105, view.frame.width, 42))
        dashBG.backgroundColor = UIColor.blackColor()
        dashBG.image = profileImage?.blurredImageWithRadius(14, iterations: 20, tintColor: UIColor.clearColor())
        dashBG.contentMode = UIViewContentMode.ScaleAspectFill
        dashBG.clipsToBounds = true
        self.view = dashBG
        var dashProfile = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.height, height: view.frame.height))
        dashProfile.image = profileImage
        self.view.addSubview(dashProfile)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
