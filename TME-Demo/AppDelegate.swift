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
        
        
        
//        TMEService.shared.fetchCategories(success: { (category) in
//            print("category: \(category.name)")
//        }) { (error) in
//            print("error: \(error.localizedDescription)")
//        }
//        
//        TMEService.shared.fetchListing("0001", success: { (response) in
//            print("category: \(response.list?.count)")
//        }) { (error) in
//            print("error: \(error.localizedDescription)")
//        }
//
//        TMEService.shared.fetchListingDetail(6865995, success: { (detail) in
//            print("category: \(detail.photos?.count)")
//        }) { (error) in
//            print("error: \(error.localizedDescription)")
//        }
        
        return true
    }
}

