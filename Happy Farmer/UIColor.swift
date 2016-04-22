//
//  UIColor.swift
//  Happy Farmer
//
//  Created by Alexander on 22.04.16.
//  Copyright © 2016 Alexander Grebenschikov. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hex: Int, alpha: CGFloat = 1) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 256
        let g = CGFloat((hex & 0x00FF00) >> 8) / 256
        let b = CGFloat(hex & 0x0000FF) / 256
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
}
