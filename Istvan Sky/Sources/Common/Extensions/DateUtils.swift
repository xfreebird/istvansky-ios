//
//  DateUtils.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/2/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation
import Marshal

extension Date {
    static func fromISO8601String(_ dateString: String) -> Date? {
        let formatter = DateFormatter.ISO8601Formatter()
        return formatter.date(from: dateString)
    }
}

extension Date: ValueType {
    public static func value(from object: Any) throws -> Date {
        guard let dateString = object as? String else {
            throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object))
        }

        guard let date = Date.fromISO8601String(dateString) else {
            throw MarshalError.typeMismatch(expected: "ISO8601 date string", actual: dateString)
        }
        return date
    }
}
