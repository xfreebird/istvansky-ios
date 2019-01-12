//
//  MainMenuViewController.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit

protocol MainMenuView: class {
    
}

class MainMenuViewController: UITabBarController, MainMenuView {

    var presenter: MainMenuPresenter!
    var homeBuilder: HomeBuilder!
    var tourBuilder: TourEventsBuilder!
    var healingMusicBuilder: HealingMusicModuleBuilder!
    var donateBuilder: DonateModuleBuilder!
    var moreBuilder: MoreModuleBuilder!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewControllers = createAllChildViewController(menuViewModelItems: presenter.menuItems())
    }
    
    func createVC(viewModel: FLViewModel) -> UIViewController {
        var viewController = UIViewController()
        switch viewModel.type {
        case .home:
            viewController = homeBuilder.buildHomeController()
        case .tour:
            viewController = tourBuilder.buildTourEventsViewController()
        case .music:
            viewController = healingMusicBuilder.buildHealingMusicController()
        case .donate:
            viewController = donateBuilder.buildDonateController()
        case .more:
            viewController = moreBuilder.buildMoreController()
        default:
            break
        }

        let image = UIImage(named: viewModel.imageName ?? "")
        viewController.navigationItem.title = viewModel.title
        viewController.tabBarItem = UITabBarItem(title: viewModel.title, image: image, tag: 0)
        let navController = ExtendedUINavigationController(rootViewController: viewController)
        return navController
    }
    
    func createAllChildViewController(menuViewModelItems: [FLViewModel]) -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        menuViewModelItems.forEach { item in
            let vc = createVC(viewModel: item)
            viewControllers.append(vc)
        }
        return viewControllers
    }
}
