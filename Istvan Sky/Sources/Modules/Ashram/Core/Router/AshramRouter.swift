//
//  AshramRouter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 05/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol AshramRouter {
    func navigateToItemDetails(viewModel: FLViewModel)
}

class AshramRouterImp: AshramRouter {

    weak var viewController: AshramBlogViewController!

    func navigateToItemDetails(viewModel: FLViewModel) {
        let vc = AshramBlogItemDetailsViewController()
        _ = vc.view
        vc.updateView(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

}
