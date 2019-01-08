//
//  EntryViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/2/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRootViewController()
    }
}
