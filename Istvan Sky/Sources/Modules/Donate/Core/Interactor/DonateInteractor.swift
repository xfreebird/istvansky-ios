//
//  DonateInteractor.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 07/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol DonateInteractor {
    func donateItem() -> BasicItem?
}

class DonateInteractorImp: DonateInteractor {
    let contentService: ContentService!
    
    init(contentService: ContentService) {
        self.contentService = contentService
    }
    
    func donateItem() -> BasicItem? {
        return contentService.topItem(type: .donate)
    }
}
