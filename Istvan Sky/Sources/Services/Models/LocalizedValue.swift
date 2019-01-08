//
//  LocalizedValue.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/2/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation
import Marshal

struct LocalizedValue {
    let localized: String?
}

extension LocalizedValue: ValueType {
    public static func value(from object: Any) throws -> LocalizedValue {
        let defaultAppLanguage = NSLocale.defaultAppLanguage()
        let appLanguage = NSLocale.appLanguage()

        if let value = object as? String {
            return LocalizedValue(localized: value)
        } else if let value = object as? NSDictionary {
            if let valueAppLanguage = value[appLanguage] as? String {
                return LocalizedValue(localized: valueAppLanguage)
            } else if let valueDefaultAppLanguage = value[defaultAppLanguage] as? String {
                return LocalizedValue(localized: valueDefaultAppLanguage)
            }
        }
        
        return LocalizedValue(localized: nil)
    }
}
