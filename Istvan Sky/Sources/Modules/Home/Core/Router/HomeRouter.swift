//
//  HomeRouter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit

protocol HomeRouter {
    func navigateToFeedItemDetails(viewModel: FLViewModel)
    func navigateToAboutIstvan(viewModel: FLViewModel)
    func navigateToAshram(viewModel: FLViewModel)
    func navigateToWebPage(viewModel: FLViewModel)
    func navigateToWebPage(webUrl: String?)
    func navigateToTourScreen()
    func navigateToDonateScreen()
    func navigateToHealingMusicScreen()
}

class HomeRouterImp: HomeRouter {
    weak var viewController: HomeViewController!
    var ashramBuilder: AshramModuleBuilder

    init(ashramBuilder: AshramModuleBuilder) {
        self.ashramBuilder = ashramBuilder
    }

    func navigateToFeedItemDetails(viewModel: FLViewModel) {
        let vc = FeedItemDetailsViewController()
        _ = vc.view
        vc.presenter = viewController.presenter
        vc.updateView(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAboutIstvan(viewModel: FLViewModel) {
        let vc = AboutIstvanViewController()
        _ = vc.view
        vc.presenter = viewController.presenter
        vc.updateView(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAshram(viewModel: FLViewModel) {
        let vc = ashramBuilder.buildAshramBlogViewController()
        _ = vc.view
        vc.navigationController?.navigationItem.title = viewModel.title
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func navigateToWebPage(viewModel: FLViewModel) {
        navigateToWebPage(webUrl: viewModel.webUrl)
    }
    
    func navigateToWebPage(webUrl: String?) {
        if let webUrl = webUrl, let url = URL(string: webUrl) {
            viewController.openWebPage(url: url)
        }
    }

    func navigateToTourScreen() {
        viewController.tabBarController?.selectedIndex = 2
    }
    
    func navigateToDonateScreen() {
        viewController.tabBarController?.selectedIndex = 3
    }
    
    func navigateToHealingMusicScreen() {
        viewController.tabBarController?.selectedIndex = 1
    }
}
