//
//  UIColorUtils.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/4/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r red: Int, g green: Int, b blue: Int, a alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alpha >= 0 && alpha <= 1.0, "Invalid alpha component")
        
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    static func globalTintColor() -> UIColor {
        return UIColor(r: 253, g: 165, b: 41)
    }
    
    static func darkGrayColor() -> UIColor {
        return UIColor(r: 28, g: 28, b: 30)
    }
    
    static func actionButtonBorderColor() -> UIColor {
        return UIColor(r: 208, g: 93, b: 47)
    }

    
}
