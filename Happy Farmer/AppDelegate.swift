//
//  AppDelegate.swift
//  Happy Farmer
//
//  Created by Alexander on 22.04.16.
//  Copyright © 2016 Alexander Grebenschikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let harvestViewController = HarvestViewController()
        let navigationController = NavigationController(rootViewController: harvestViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
}

