//
//  HealingMusicBuilder.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 06/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit
import Swinject

protocol HealingMusicModuleBuilder {
    func buildHealingMusicController() -> HealingMusicViewController
}

class HealingMusicDefaultModuleBuilder: HealingMusicModuleBuilder {

    let container = Container(parent: ServicesContainer.default)

    func buildHealingMusicController() -> HealingMusicViewController {

        container.register(HealingMusicInteractor.self) { _ in
            HealingMusicInteractorImp(contentService: self.container.resolve(ContentService.self)!)
        }

        container.register(HealingMusicViewController.self) { _ in

            HealingMusicViewController(nibName: String(describing: HealingMusicViewController.self), bundle: Bundle.main)

            }.initCompleted { container, view in

                view.presenter = container.resolve(HealingMusicPresenter.self)
        }

        container.register(HealingMusicRouter.self) { container in
            let router = HealingMusicRouterImp()
            router.viewController = container.resolve(HealingMusicViewController.self)!
            return router
        }

        container.register(HealingMusicPresenter.self) { container in
            HealingMusicPresenterImp(view: container.resolve(HealingMusicViewController.self)!,
                                interactor: container.resolve(HealingMusicInteractor.self)!,
                                router: container.resolve(HealingMusicRouter.self)!)
        }

        return container.resolve(HealingMusicViewController.self)!
    }
    
    deinit {
        container.removeAll()
    }
}
