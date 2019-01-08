//
//  DonateBuilder.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 07/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit
import Swinject

protocol DonateModuleBuilder {
    func buildDonateController() -> DonateViewController
}

class DonateDefaultModuleBuilder: DonateModuleBuilder {
    let container = Container(parent: ServicesContainer.default)

    func buildDonateController() -> DonateViewController {

        container.register(DonateInteractor.self) { _ in
            DonateInteractorImp(contentService: self.container.resolve(ContentService.self)!)
        }

        container.register(DonateViewController.self) { _ in

            DonateViewController(nibName: String(describing: DonateViewController.self), bundle: Bundle.main)

            }.initCompleted { container, view in

                view.presenter = container.resolve(DonatePresenter.self)
        }

        container.register(DonateRouter.self) { container in
            let router = DonateRouterImp()
            router.viewController = container.resolve(DonateViewController.self)!
            return router
        }

        container.register(DonatePresenter.self) { container in
            DonatePresenterImp(view: container.resolve(DonateViewController.self)!,
                                interactor: container.resolve(DonateInteractor.self)!,
                                router: container.resolve(DonateRouter.self)!)
        }

        return container.resolve(DonateViewController.self)!
    }
}
