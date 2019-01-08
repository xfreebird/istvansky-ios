//
//  HealingMusicRouter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 06/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit

protocol HealingMusicRouter {
    func navigateToMeditationDetails(viewModel: FLViewModel)
    func navigateToMusicProvider(viewModel: FLViewModel)
    func navigateToWebPage(viewModel: FLViewModel)
    func navigateToWebPage(webUrl: String?)
}

class HealingMusicRouterImp: HealingMusicRouter {
    weak var viewController: HealingMusicViewController!
    
    func navigateToMeditationDetails(viewModel: FLViewModel) {
        let vc = MeditationDetailsViewController()
        _ = vc.view
        //vc.presenter = viewController.presenter
        vc.updateView(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMusicProvider(viewModel: FLViewModel) {
        let vc = AboutIstvanViewController()
        _ = vc.view
        //vc.presenter = viewController.presenter
        vc.updateView(viewModel: viewModel)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToWebPage(viewModel: FLViewModel) {
        navigateToWebPage(webUrl: viewModel.webUrl)
    }
    
    func process(webUrl: String) -> URL? {
        if webUrl.starts(with: "https://www.deezer") &&
            UIApplication.shared.canOpenURL(URL(string: "deezer://")!) {
            let newWebUrl = webUrl.replacingOccurrences(of: "https://www.deezer.com", with: "deezer://")
            return URL(string: newWebUrl)
        } else if webUrl.starts(with: "https://www.facebook.com") &&
            UIApplication.shared.canOpenURL(URL(string: "fb://")!) {
            let newWebUrl = webUrl.replacingOccurrences(of: "https://www.facebook.com", with: "fb://profile")
            return URL(string: newWebUrl)
        }

        return URL(string: webUrl)
    }
    
    func navigateToWebPage(webUrl: String?) {
        if let webUrl = webUrl, let newUrl = process(webUrl: webUrl) {
            UIApplication.shared.open(newUrl)
        }
    }
}
