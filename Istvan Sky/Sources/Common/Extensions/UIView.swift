//
//  UIView.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 11/01/2019.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

extension UIView {
    func makeRoundCorners() {
        layer.cornerRadius = 5
        clipsToBounds = true
    }
}
