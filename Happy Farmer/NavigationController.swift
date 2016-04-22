//
//  NavigationController.swift
//  Happy Farmer
//
//  Created by Alexander on 22.04.16.
//  Copyright © 2016 Alexander Grebenschikov. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func loadView() {
        super.loadView()
        
        navigationBar.barTintColor = UIColor(hex: 0x0A2E46)
        navigationBar.tintColor = UIColor(hex: 0xE4E4E4)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(hex: 0xE4E4E4)]
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [.LandscapeLeft, .LandscapeRight]
    }

}
