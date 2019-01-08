//
//  AshramPresenter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 05/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol AshramPresenter {
    func sectionsCount() -> Int
    func item(index: Int) -> FLViewModel
    func itemSelected(index: Int)
    func headerImage() -> String
    func title() -> String
    func viewDidLoad()
}

class AshramPresenterImp: AshramPresenter {

    weak var view: AshramView!
    var interactor: AshramInteractor!
    var router: AshramRouter!
    var cachedData: [FLViewModel] = []
    var headerImageName: String? = nil
    var viewTitle: String? = nil

    init(view: AshramView, interactor: AshramInteractor, router: AshramRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        cachedData = data()
        view.updateView(viewModel: cachedData)
    }
    
    func data() -> [FLViewModel] {
        if let ashramItem = interactor.ashramItem() {
            let viewModel: FLViewModel = ashramItem.convert()
            headerImageName = viewModel.imageName
            viewTitle = viewModel.title
            if let viewModelItems = viewModel.items {
                return viewModelItems
            }
        }
        
        return []
    }

    func sectionsCount() -> Int {
        return cachedData.count
    }

    func item(index: Int) -> FLViewModel {
        return cachedData[index]
    }
    
    func itemSelected(index: Int) {
        let viewModel = item(index: index)
        router.navigateToItemDetails(viewModel: viewModel)
    }
    
    func headerImage() -> String {
        return headerImageName ?? ""
    }
    
    func title() -> String {
        return viewTitle ?? ""
    }
}
