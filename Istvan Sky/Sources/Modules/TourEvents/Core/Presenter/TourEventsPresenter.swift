//
//  TourEventsPresenter.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation
import UIKit
import EventKitUI

protocol TourEventsPresenter: class {
    func viewDidLoad()
    func sectionsCount() -> Int
    func itemAtIndexPath(indexPath: IndexPath) -> FLViewModel
    func bookItem(index: Int)
    func moreItems(index: Int)
    func addToCalendar(index: Int)
    func shareItem(index: Int)
    func reloadData()
}

class TourEventsPresenterImp: NSObject, TourEventsPresenter {

    weak var view: TourEventsView!
    var interactor: TourEventsInteractor!
    var router: TourEventsRouter!
    var cachedData: [FLViewModel] = []

    init(view: TourEventsView, interactor: TourEventsInteractor, router: TourEventsRouter) {
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
        
        if cachedData.count > 0 {
            view.updateView()
        } else {
            view.showNoEvents()
        }
    }
    
    func data() -> [FLViewModel] {
        if let tourItem = interactor.tourItem() {
            let viewModel: FLViewModel = tourItem.convert()
            if let viewModelItems = viewModel.items {
                return viewModelItems
            }
        }
        
        return []
    }

    func sectionsCount() -> Int {
        return cachedData.count
    }
    
    func itemAtIndexPath(indexPath: IndexPath) -> FLViewModel {
        return cachedData[indexPath.section]
    }

    func bookItem(index: Int) {
        let item = cachedData[index]
        if let urlAddress = item.webUrl, let url = URL(string: urlAddress) {
            router.navigateToBookScreen(url: url)
        }
    }

    func moreItems(index: Int) {
        view.showMoreScreen(itemIndex: index)
    }
    
    func moreActions() {
    }
    
    func shareItem(index: Int) {
        let item = cachedData[index]
        if let urlAddress = item.webUrl,
            let url = URL(string: urlAddress),
            let title = item.title {
            view.showShareScreen(itemIndex: index, message: "Istvan Sky - \(title)", url: url)
        }
    }

    func addToCalendar(index: Int) {
        requestAccessCalendarPermissionAndShowAddEvent(index: index)
    }
    
    func createCalendarEvent(for index:Int, eventStore: EKEventStore) {
        let item = cachedData[index]
        let event = EKEvent(eventStore: eventStore)
        event.title = item.title
        event.startDate = item.eventDate
        event.endDate = item.eventEndDate
        event.timeZone = item.eventTimeZone
        
        if let urlAddress = item.webUrl,
            let url = URL(string: urlAddress) {
            event.url = url
        }
        view.showAddEvent(for: event, eventStore: eventStore)
    }
    
    func requestAccessCalendarPermissionAndShowAddEvent(index: Int) {
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            createCalendarEvent(for: index, eventStore: eventStore)
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion:
                {[weak self] (granted: Bool, error: Error?) -> Void in
                    if granted {
                        self?.createCalendarEvent(for: index, eventStore: eventStore)
                    }
            })
        default:
            break
        }

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
