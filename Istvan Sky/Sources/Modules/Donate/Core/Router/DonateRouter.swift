//
//  DonateRouter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 07/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit

protocol DonateRouter {
    func navigateToWebPage(webUrl: String?)
}

class DonateRouterImp: DonateRouter {
    weak var viewController: DonateViewController!

    func navigateToWebPage(webUrl: String?) {
        if let webUrl = webUrl, let newUrl = URL(string: webUrl) {
            UIApplication.shared.open(newUrl)
        }
    }
}
