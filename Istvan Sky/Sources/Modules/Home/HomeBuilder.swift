//
//  HomeBuilder.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit
import Swinject

protocol HomeBuilder {
    func buildHomeController() -> HomeViewController
}

class HomeDefaultModuleBuilder: HomeBuilder {
    let container: Container = Container(parent: ServicesContainer.default)

    func buildHomeController() -> HomeViewController {

        container.register(AshramModuleBuilder.self) { _ in
            AshramDefaultModuleBuilder()
        }
        
        container.register(HomeInteractor.self) { _ in
            HomeInteractorImp(contentService: self.container.resolve(ContentService.self)!)
        }

        container.register(HomeViewController.self) { _ in

            HomeViewController(nibName: String(describing: HomeViewController.self), bundle: Bundle.main)

            }.initCompleted { container, view in

                view.presenter = container.resolve(HomePresenter.self)
        }

        container.register(HomeRouter.self) { container in
            let router = HomeRouterImp(ashramBuilder: container.resolve(AshramModuleBuilder.self)!)
            router.viewController = container.resolve(HomeViewController.self)!
            return router
        }

        container.register(HomePresenter.self) { container in
            HomePresenterImp(view: container.resolve(HomeViewController.self)!,
                                interactor: container.resolve(HomeInteractor.self)!,
                                router: container.resolve(HomeRouter.self)!)
        }

        return container.resolve(HomeViewController.self)!
    }
    
    deinit {
        container.removeAll()
    }
}
