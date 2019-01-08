//
//  HealingMusicInteractor.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 06/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol HealingMusicInteractor {
    func healingMusicItem() -> BasicItem?
}

class HealingMusicInteractorImp: HealingMusicInteractor {
    let contentService: ContentService!
    
    init(contentService: ContentService) {
        self.contentService = contentService
    }
    
    func healingMusicItem() -> BasicItem? {
        return contentService.topItem(type: .music)
    }
}
