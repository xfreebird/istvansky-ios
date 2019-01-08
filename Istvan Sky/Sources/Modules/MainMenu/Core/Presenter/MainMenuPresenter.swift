//
//  MainMenuPresenter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol MainMenuPresenter {
    func menuItems() -> [FLViewModel]
}

class MainMenuPresenterImp: MainMenuPresenter {
    weak var view: MainMenuView!
    var interactor: MainMenuInteractor!
    var router: MainMenuRouter!

    init(view: MainMenuView, interactor: MainMenuInteractor, router: MainMenuRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func menuItems() -> [FLViewModel] {
        guard let items = interactor.menuItems() else {
            return []
        }
        
        var viewModels: [FLViewModel] = []
        items.forEach { item in
            viewModels.append(item.convert())
        }

        return viewModels
    }
}
