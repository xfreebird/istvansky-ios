//
//  TimeZone.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/5/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation
import Marshal

extension TimeZone: ValueType {
    public static func value(from object: Any) throws -> TimeZone {
        guard let timeZoneString = object as? String else {
            throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object))
        }
        
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: timeZoneString)
        guard let value = number?.floatValue, let timeZone = TimeZone(secondsFromGMT: Int(value * 3600)) else {
            throw MarshalError.typeMismatch(expected: "Float value", actual: timeZoneString)
        }
        
        return timeZone
    }
}
