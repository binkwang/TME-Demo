//
//  AppDelegate.swift
//  TME-Demo
//
//  Created by Bink Wang on 8/16/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        guard let splitViewController = window?.rootViewController as? UISplitViewController,
            let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
            let categoryViewController = leftNavController.topViewController as? TMECategoryViewController,
            let rightNavController = splitViewController.viewControllers.last as? UINavigationController,
            let listingViewController = rightNavController.topViewController as? TMEListingViewController
            else { fatalError() }

        categoryViewController.leafCategorySelectionDelegate = listingViewController
        listingViewController.navigationItem.leftItemsSupplementBackButton = true
        listingViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
        return true
    }
}

