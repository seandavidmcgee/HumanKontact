//
//  AppDelegate.swift
//  keyboardTest
//
//  Created by Neetin Sharma on 3/11/15.
//  Copyright (c) 2015 3 Callistos Services. All rights reserved.
//

import UIKit
import KGFloatingDrawer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let kKGDrawersStoryboardName = "Main"
    
    let kKGDrawerFavsViewControllerStoryboardId = "KGDrawerFavsViewControllerStoryboardId"
    let kKGDrawerContactsViewControllerStoryboardId = "KGDrawerContactsViewControllerStoryboardId"
    let kKGDrawerBrowseViewControllerStoryboardId = "KGDrawerBrowseViewControllerStoryboardId"
    let kKGDrawerRecentsViewControllerStoryboardId = "KGDrawerRecentsViewControllerStoryboardId"
    let kKGDrawerSettingsViewControllerStoryboardId = "KGDrawerSettingsViewControllerStoryboardId"
    let kKGRightDrawerStoryboardId = "KGRightDrawerViewControllerStoryboardId"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.rootViewController = drawerViewController
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private var _drawerViewController: KGDrawerViewController?
    var drawerViewController: KGDrawerViewController {
        get {
            if let viewController = _drawerViewController {
                return viewController
            }
            return prepareDrawerViewController()
        }
    }
    
    func prepareDrawerViewController() -> KGDrawerViewController {
        let drawerViewController = KGDrawerViewController()
        var bgImage = UIImage(named: "bkg")
        var effectImage : UIImage!
        var blurringLevel : CGFloat = 5.0
        
        effectImage = bgImage!.applyBlurWithRadius(blurringLevel, tintColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), saturationDeltaFactor: 1.0, maskImage: nil)
        
        drawerViewController.centerViewController = drawerFavsViewController()
        drawerViewController.rightViewController = rightViewController()
        drawerViewController.backgroundImage = effectImage!
        
        _drawerViewController = drawerViewController
        
        return drawerViewController
    }
    
    private func drawerStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: kKGDrawersStoryboardName, bundle: nil)
        return storyboard
    }
    
    private func viewControllerForStoryboardId(storyboardId: String) -> UIViewController {
        let viewController: UIViewController = drawerStoryboard().instantiateViewControllerWithIdentifier(storyboardId) as! UIViewController
        return viewController
    }
    
    func drawerFavsViewController() -> UIViewController {
        let viewController = viewControllerForStoryboardId(kKGDrawerFavsViewControllerStoryboardId)
        return viewController
    }
    
    func drawerContactsViewController() -> UIViewController {
        let viewController = viewControllerForStoryboardId(kKGDrawerContactsViewControllerStoryboardId)
        return viewController
    }
    
    func browseContactsViewController() -> UIViewController {
        let viewController = viewControllerForStoryboardId(kKGDrawerBrowseViewControllerStoryboardId)
        return viewController
    }
    
    func drawerRecentsViewController() -> UIViewController {
        let viewController = viewControllerForStoryboardId(kKGDrawerRecentsViewControllerStoryboardId)
        return viewController
    }
    
    func drawerSettingsViewController() -> UIViewController {
        let viewController = viewControllerForStoryboardId(kKGDrawerSettingsViewControllerStoryboardId)
        return viewController
    }
    
    private func rightViewController() -> UIViewController {
        let viewController = viewControllerForStoryboardId(kKGRightDrawerStoryboardId)
        return viewController
    }
    
    func toggleRightDrawer(sender:AnyObject, animated:Bool) {
        _drawerViewController?.toggleDrawer(.Right, animated: true, complete: { (finished) -> Void in
            // do nothing
        })
    }
    
    private var _centerViewController: UIViewController?
    var centerViewController: UIViewController {
        get {
            if let viewController = _centerViewController {
                return viewController
            }
            return drawerContactsViewController()
        }
        set {
            if let drawerViewController = _drawerViewController {
                drawerViewController.closeDrawer(drawerViewController.currentlyOpenedSide, animated: true) { finished in }
                if drawerViewController.centerViewController != newValue {
                    drawerViewController.centerViewController = newValue
                }
            }
            _centerViewController = newValue
        }
    }
}

