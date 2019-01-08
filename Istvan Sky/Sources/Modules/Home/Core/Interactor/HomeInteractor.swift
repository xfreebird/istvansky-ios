//
//  HomeInteractor.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol HomeInteractor {
    func homeItem() -> BasicItem?
    func feedItem() -> BasicItem?
    func aboutItem() -> BasicItem?
    func reloadData(completion: (() -> Void)?)
}

class HomeInteractorImp: HomeInteractor {
    let contentService: ContentService!
    
    init(contentService: ContentService) {
        self.contentService = contentService
    }
    
    func homeItem() -> BasicItem? {
        return contentService.topItem(type: .home)
    }
    
    func feedItem() -> BasicItem? {
        return contentService.topItem(type: .feed, data: homeItem()?.items)
    }
    
    func aboutItem() -> BasicItem? {
        return contentService.topItem(type: .about, data: homeItem()?.items)
    }
    
    func reloadData(completion: (() -> Void)?) {
        contentService.update(completion: completion)
    }
}
