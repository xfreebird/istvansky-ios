//
//  AshramBuilder.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 05/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit
import Swinject

protocol AshramModuleBuilder {
    func buildAshramBlogViewController() -> AshramBlogViewController
}

class AshramDefaultModuleBuilder: AshramModuleBuilder {
    let container = Container(parent: ServicesContainer.default)

    func buildAshramBlogViewController() -> AshramBlogViewController {

        container.register(AshramInteractor.self) { _ in
            AshramInteractorImp(contentService: self.container.resolve(ContentService.self)!)
        }

        container.register(AshramBlogViewDataSource.self) { _ in
            AshramBlogViewDataSourceImp(presenter: self.container.resolve(AshramPresenter.self)!)
        }
        
        container.register(AshramBlogViewDelegate.self) { _ in
            AshramBlogViewDelegateImp(presenter: self.container.resolve(AshramPresenter.self)!)
        }

        container.register(AshramBlogViewController.self) { _ in

            AshramBlogViewController(nibName: String(describing: AshramBlogViewController.self), bundle: Bundle.main)

            }.initCompleted { container, view in

                view.presenter = container.resolve(AshramPresenter.self)
                view.tableViewDataSource = container.resolve(AshramBlogViewDataSource.self)
                view.tableViewDelegate = container.resolve(AshramBlogViewDelegate.self)
        }

        container.register(AshramRouter.self) { container in
            let router = AshramRouterImp()
            router.viewController = container.resolve(AshramBlogViewController.self)!
            return router
        }

        container.register(AshramPresenter.self) { container in
            AshramPresenterImp(view: container.resolve(AshramBlogViewController.self)!,
                                interactor: container.resolve(AshramInteractor.self)!,
                                router: container.resolve(AshramRouter.self)!)
        }

        return container.resolve(AshramBlogViewController.self)!
    }
    
    deinit {
        container.removeAll()
    }
}
