//
//  MorePresenter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 07/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol MorePresenter: class {
    func viewDidLoad()
    func item(index: Int) -> FLViewModel
    func numberOfItems() -> Int
    func itemSelected(index: Int)
}

class MorePresenterImp: MorePresenter {

    weak var view: MoreView!
    var interactor: MoreInteractor!
    var router: MoreRouter!

    init(view: MoreView, interactor: MoreInteractor, router: MoreRouter) {
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
        return interactor.moreItem()?.convert()
    }
    
    func numberOfItems() -> Int {
        return data()?.items?.count ?? 0
    }
    
    func appVersionViewModel(title: String) -> FLViewModel {
        let appVersion = "\(title): \(interactor.appVersion())"
        return FLViewModel(title: appVersion, type: .version)
    }
    
    func item(index: Int) -> FLViewModel {
        if let data = data(), let items = data.items {
            var viewModel = items[index]
            
            if let title = viewModel.title, viewModel.type == .version {
                viewModel = appVersionViewModel(title: title)
            }
            
            return viewModel
        }
        
        return FLViewModel()
    }
    
    func itemSelected(index: Int) {
        let viewModel = item(index: index)
        switch viewModel.type {
        case .tandc:
            router.navigateLocalHTMLPage(url: interactor.tandcFileURL(), title: viewModel.title)
        case .privacyPolicy:
            router.navigateLocalHTMLPage(url: interactor.privacyFileURL(), title: viewModel.title)
        case .thirdParty:
            router.navigateLocalHTMLPage(url: interactor.thirdpartyURL(), title: viewModel.title)

        default:
            break
        }

    }
}
