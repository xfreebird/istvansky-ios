//
//  MoreInteractor.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 07/01/2019.
//  Copyright © 2019 Istvan Sky. All rights reserved.
//

import Foundation

protocol MoreInteractor {
    func moreItem() -> BasicItem?
    func appVersion() -> String
    func tandcFileURL() -> URL
    func privacyFileURL() -> URL
    func thirdpartyURL() -> URL
    func clearCache()
}

class MoreInteractorImp: MoreInteractor {
    let contentService: ContentService!
    
    init(contentService: ContentService) {
        self.contentService = contentService
    }
    
    func moreItem() -> BasicItem? {
        return contentService.topItem(type: .more)
    }
    
    func appVersion() -> String {
        let version = Bundle.appVersion()
        let build = Bundle.appBuildNumber()
        return "\(version) #\(build)"
    }
    
    func tandcFileURL() -> URL {
        return Bundle.bundledTAndCFileURL()
    }

    func privacyFileURL() -> URL {
        return Bundle.bundledPrivacyFileURL()
    }
    
    func thirdpartyURL() -> URL {
        return Bundle.bundledThirdPartyFileURL()
    }
    
    func clearCache() {
        FileManager.clearDocumentsDirectory()
    }

}
