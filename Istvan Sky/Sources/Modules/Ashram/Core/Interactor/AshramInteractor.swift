//
//  AshramInteractor.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 05/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol AshramInteractor {
    func ashramItem() -> BasicItem?
}

class AshramInteractorImp: AshramInteractor {
    let contentService: ContentService!
    
    init(contentService: ContentService) {
        self.contentService = contentService
    }
    
    func homeItem() -> BasicItem? {
        return contentService.topItem(type: .home)
    }

    func ashramItem() -> BasicItem? {
        return contentService.topItem(type: .ashram, data: homeItem()?.items)
    }
}
