//
//  TourEventsBuilder.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import UIKit
import Swinject

protocol TourEventsBuilder {
    func buildTourEventsViewController() -> TourEventsViewController!
}

class TourEventsDefaultModuleBuilder: TourEventsBuilder {
    let container = Container(parent: ServicesContainer.default)
    
    func buildTourEventsViewController() -> TourEventsViewController! {

        container.register(TourEventsInteractor.self) { _ in
            TourEventsInteractorImp(contentService: self.container.resolve(ContentService.self)!)
        }
        
        container.register(TourEventsDataSource.self) { _ in
            TourEventsDataSourceImp(presenter: self.container.resolve(TourEventsPresenter.self)!)
        }

        container.register(TourEventsDelegate.self) { _ in
            TourEventsDelegateImp(presenter: self.container.resolve(TourEventsPresenter.self)!)
        }

        container.register(TourEventsViewController.self) { _ in

            TourEventsViewController(nibName: String(describing: TourEventsViewController.self), bundle: Bundle.main)

            }.initCompleted { container, view in

                view.presenter = container.resolve(TourEventsPresenter.self)
                view.tableViewDelegate = container.resolve(TourEventsDelegate.self)
                view.tableViewDataSource = container.resolve(TourEventsDataSource.self)
        }

        container.register(TourEventsRouter.self) { container in
            let router = TourEventsRouterImp()
            router.viewController = container.resolve(TourEventsViewController.self)!
            return router
        }

        container.register(TourEventsPresenter.self) { container in
            TourEventsPresenterImp(view: container.resolve(TourEventsViewController.self)!,
                                interactor: container.resolve(TourEventsInteractor.self)!,
                                router: container.resolve(TourEventsRouter.self)!)
        }

        return container.resolve(TourEventsViewController.self)!
    }
    
    deinit {
        container.removeAll()
    }
}
