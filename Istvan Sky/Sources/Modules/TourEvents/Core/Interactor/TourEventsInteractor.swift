//
//  TourEventsInteractor.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol TourEventsInteractor {
    func tourItem() -> BasicItem?
    func reloadData(completion: (() -> Void)?)
}

class TourEventsInteractorImp: TourEventsInteractor {
    let contentService: ContentService!
    
    init(contentService: ContentService) {
        self.contentService = contentService
    }
    
    func tourItem() -> BasicItem? {
        return contentService.topItem(type: .tour)
    }
    
    func reloadData(completion: (() -> Void)?) {
        contentService.update(completion: completion)
    }
}
