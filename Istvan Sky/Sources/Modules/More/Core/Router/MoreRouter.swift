//
//  MoreRouter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 07/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol MoreRouter {
    func navigateLocalHTMLPage(url: URL, title: String?)
}

class MoreRouterImp: MoreRouter {

    weak var viewController: MoreViewController!

    func navigateLocalHTMLPage(url: URL, title: String?) {
        let vc = HTMLFileViewController()
        vc.url = url
        vc.title = title
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
