//
//  HealingMusicPresenter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 06/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol HealingMusicPresenter: FRProxyDataPresenter {
    func shareUrl() -> URL?
    func viewDidLoad()
    func sectionsCount() -> Int
    func itemsCount(sectionIndex: Int) -> Int
    func didSelectItem(indexPath: IndexPath, isChildListIndex: Bool)
    func itemAtIndexPath(indexPath: IndexPath, isChildListIndex: Bool) -> FLViewModel
}

class HealingMusicPresenterImp: HealingMusicPresenter {    
    weak var view: HealingMusicView!
    var interactor: HealingMusicInteractor!
    var router: HealingMusicRouter!
    var cachedData: [FLViewModel] = []

    init(view: HealingMusicView, interactor: HealingMusicInteractor, router: HealingMusicRouter) {
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
        if let musicItem = interactor.healingMusicItem(),
            let webUrl = musicItem.webUrl?.localized,
            let url = URL(string: webUrl) {
            return url
        }
        
        return nil
    }
    
    func data() -> [FLViewModel] {
        if let musicItem = interactor.healingMusicItem() {
            let viewModel: FLViewModel = musicItem.convert()
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
        case .meditations:
            router.navigateToMeditationDetails(viewModel: item)
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
    
    func processAction(for type: FLViewModelType) {
        let supportItem = cachedData.first { (item) -> Bool in
            item.type == .support
        }
        
        if let supportItem = supportItem {
            let actionedItem = supportItem.items?.first(where: { (item) -> Bool in
                item.type == type
            })
            
            router.navigateToWebPage(webUrl: actionedItem?.webUrl)
        }
    }

}
