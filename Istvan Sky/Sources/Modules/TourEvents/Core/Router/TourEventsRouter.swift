//
//  TourEventsRouter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit
import SafariServices

protocol TourEventsRouter {
    func navigateToBookScreen(url: URL)
}

class TourEventsRouterImp: TourEventsRouter {

    weak var viewController: TourEventsViewController!

    func navigateToBookScreen(url: URL) {
        viewController.openWebPage(url: url)
    }
}
