//
//  MainMenuInteractor.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 02/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol MainMenuInteractor {
    func menuItems() -> [BasicItem]?
}

class MainMenuInteractorImp: MainMenuInteractor {
    let contentService: ContentService!
    
    init(contentService: ContentService) {
        self.contentService = contentService
    }
    
    func menuItems() -> [BasicItem]? {
        return contentService.menuItems()
    }
}
