//
//  UIButtonUtils.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/6/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

extension UIButton {
    func configure(title: String?, isHighlighted: Bool = false) {
        let color: UIColor = isHighlighted ? .white : .black

        backgroundColor = isHighlighted ? UIColor.globalTintColor() : .clear
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.0
        layer.borderColor = isHighlighted ? UIColor.actionButtonBorderColor().cgColor : UIColor.lightGray.cgColor
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 21)
    }
}
