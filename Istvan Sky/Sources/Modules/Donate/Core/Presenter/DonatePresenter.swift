//
//  DonatePresenter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 07/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol DonatePresenter {
    func viewDidLoad()
    func donate()
}

class DonatePresenterImp: DonatePresenter {
    weak var view: DonateView!
    var interactor: DonateInteractor!
    var router: DonateRouter!

    init(view: DonateView, interactor: DonateInteractor, router: DonateRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        if let data = data() {
            view.updateView(viewModel: data)
        }
    }
    
    func data() -> FLViewModel? {
        return interactor.donateItem()?.convert()
    }
    
    func donate() {
        if let data = data() {
            router.navigateToWebPage(webUrl: data.webUrl)
        }
    }
}
