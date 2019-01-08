//
//  HomePresenter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol HomePresenter: FRProxyDataPresenter {
    func viewDidLoad()
    func reloadData()
    func shareUrl() -> URL?
    func processFeedItemAction(type: FLViewModelType, webUrl: String?)
}

class HomePresenterImp: HomePresenter {
    
    weak var view: HomeView!
    var interactor: HomeInteractor!
    var router: HomeRouter!
    var cachedData: [FLViewModel] = []

    init(view: HomeView, interactor: HomeInteractor, router: HomeRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        loadData()
        monitorDataChanges()
    }
    
    func monitorDataChanges() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(newDataEvent(_:)),
                                               name: .didReceiveNewData,
                                               object: nil)
    }
    
    @objc func newDataEvent(_ notification: Notification){
        loadData()
    }

    func loadData() {
        cachedData = data()
        view.updateView(viewModel: cachedData)
    }
    
    func shareUrl() -> URL? {
        if let homeItem = interactor.homeItem(),
            let webUrl = homeItem.webUrl?.localized,
            let url = URL(string: webUrl) {
            return url
        }
        
        return nil
    }

    func data() -> [FLViewModel] {
        if let homeItem = interactor.homeItem() {
            let viewModel: FLViewModel = homeItem.convert()
            if let viewModelItems = viewModel.items {
                return viewModelItems
            }
        }

        return []
    }
    
    func didSelectItem(indexPath: IndexPath, isChildListIndex: Bool) {
        
        let item = itemAtIndexPath(indexPath: indexPath, isChildListIndex: isChildListIndex)
        let rootItemIndexPath = IndexPath(row: 0, section: indexPath.section)
        let rootItem = itemAtIndexPath(indexPath: rootItemIndexPath, isChildListIndex: false)

        switch rootItem.type {
        case .booking, .contact:
            router.navigateToWebPage(viewModel: item)
        case .feed:
            router.navigateToFeedItemDetails(viewModel: item)
        case .about:
            router.navigateToAboutIstvan(viewModel: item)
        case .ashram:
            router.navigateToAshram(viewModel: item)
        default:
            break
        }
    }
    
    func itemAtIndexPath(indexPath: IndexPath, isChildListIndex: Bool) -> FLViewModel {
        if isChildListIndex {
            return cachedData[indexPath.section].items?[indexPath.item] ?? FLViewModel()
        } else {
            return cachedData[indexPath.section]
        }
    }
    
    func sectionsCount() -> Int {
        return cachedData.count
    }
    
    func itemsCount(sectionIndex: Int) -> Int {
        return cachedData[sectionIndex].items?.count ?? 0
    }
    
    func processFeedItemAction(type: FLViewModelType, webUrl: String?) {
        
        switch type {
        case .about:
            let viewModel = cachedData.first { item -> Bool in
                item.type == .about
            }
            
            if let viewModel = viewModel {
                router.navigateToAboutIstvan(viewModel: viewModel)
            }
        case .tour:
            router.navigateToTourScreen()
        case .web:
            router.navigateToWebPage(webUrl: webUrl)
        case .donate:
            router.navigateToDonateScreen()
        case .meditation, .meditations:
            router.navigateToHealingMusicScreen()
        default:
            break
        }
    }
    
    func processAction(for type: FLViewModelType) {
        
    }
    
    func reloadData() {
        interactor.reloadData { [weak self] in
            self?.loadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
