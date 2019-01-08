//
//  NSLocaleExtension.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/2/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation

extension NSLocale {
    static func defaultAppLanguage() -> String {
        return "en"
    }

    static func appLanguage() -> String {
        let appLanguage: String = Bundle.main.preferredLocalizations.first ?? defaultAppLanguage()
        return appLanguage
    }
}
