//
//  ExtendedUINavigationController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/6/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

class ExtendedUINavigationController: UINavigationController {
    private var popRecognizer: InteractivePopRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopRecognizer()
    }
    
    private func setupPopRecognizer() {
        popRecognizer = InteractivePopRecognizer(controller: self)
    }
}
