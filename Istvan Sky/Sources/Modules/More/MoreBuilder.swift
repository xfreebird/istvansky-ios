//
//  MoreBuilder.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 07/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit
import Swinject

protocol MoreModuleBuilder {
    func buildMoreController() -> MoreViewController
}

class MoreDefaultModuleBuilder: MoreModuleBuilder {
    let container = Container(parent: ServicesContainer.default)
    

    func buildMoreController() -> MoreViewController {

        container.register(MoreInteractor.self) { _ in
            MoreInteractorImp(contentService: self.container.resolve(ContentService.self)!)
        }
        
        container.register(MoreTableViewDataSource.self) { _ in
            let dataSource = MoreTableViewDataSource()
            dataSource.presenter = self.container.resolve(MorePresenter.self)
            return dataSource
        }
        
        container.register(MoreTableViewDelegate.self) { _ in
            let delegate = MoreTableViewDelegate()
            delegate.presenter = self.container.resolve(MorePresenter.self)
            return delegate
        }

        container.register(MoreViewController.self) { _ in

            MoreViewController(nibName: String(describing: MoreViewController.self), bundle: Bundle.main)

            }.initCompleted { container, view in

                view.presenter = container.resolve(MorePresenter.self)
                view.tableViewDataSource = container.resolve(MoreTableViewDataSource.self)
                view.tableViewDelegate = container.resolve(MoreTableViewDelegate.self)

        }

        container.register(MoreRouter.self) { container in
            let router = MoreRouterImp()
            router.viewController = container.resolve(MoreViewController.self)!
            return router
        }

        container.register(MorePresenter.self) { container in
            MorePresenterImp(view: container.resolve(MoreViewController.self)!,
                                interactor: container.resolve(MoreInteractor.self)!,
                                router: container.resolve(MoreRouter.self)!)
        }

        return container.resolve(MoreViewController.self)!
    }
}
