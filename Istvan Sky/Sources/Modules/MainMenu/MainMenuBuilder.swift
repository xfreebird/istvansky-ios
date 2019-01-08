//
//  MainMenuBuilder.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit
import Swinject

protocol MainMenuBuilder {
    func buildMainMenuController() -> MainMenuViewController!
}

class MainMenuDefaultModuleBuilder: MainMenuBuilder {
    let container: Container = Container(parent: ServicesContainer.default)
    
    func buildMainMenuController() -> MainMenuViewController! {

        container.register(HomeBuilder.self) { container in
            HomeDefaultModuleBuilder()
        }
        
        container.register(TourEventsBuilder.self) { container in
            TourEventsDefaultModuleBuilder()
        }
        
        container.register(HealingMusicModuleBuilder.self) { container in
            HealingMusicDefaultModuleBuilder()
        }

        container.register(DonateModuleBuilder.self) { container in
            DonateDefaultModuleBuilder()
        }

        container.register(MoreModuleBuilder.self) { container in
            MoreDefaultModuleBuilder()
        }

        container.register(MainMenuInteractor.self) { container in
            MainMenuInteractorImp(contentService: container.resolve(ContentService.self)!)
        }

        container.register(MainMenuViewController.self) { _ in

            MainMenuViewController()

            }.initCompleted { container, view in

                view.presenter = container.resolve(MainMenuPresenter.self)
                view.homeBuilder = container.resolve(HomeBuilder.self)
                view.tourBuilder = container.resolve(TourEventsBuilder.self)
                view.healingMusicBuilder = container.resolve(HealingMusicModuleBuilder.self)
                view.donateBuilder = container.resolve(DonateModuleBuilder.self)
                view.moreBuilder = container.resolve(MoreModuleBuilder.self)
        }

        container.register(MainMenuRouter.self) { container in
            let router = MainMenuRouterImp()
            router.viewController = container.resolve(MainMenuViewController.self)!
            return router
        }

        container.register(MainMenuPresenter.self) { container in
            MainMenuPresenterImp(view: container.resolve(MainMenuViewController.self)!,
                                interactor: container.resolve(MainMenuInteractor.self)!,
                                router: container.resolve(MainMenuRouter.self)!)
        }

        return container.resolve(MainMenuViewController.self)!
    }

    deinit {
        container.removeAll()
    }
}
