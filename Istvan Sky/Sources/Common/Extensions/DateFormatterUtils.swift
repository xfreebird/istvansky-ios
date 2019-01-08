//
//  DateFormatterUtils.swift
//  Istvan Sky
//
//  Created by Nicolae Ghimbovschi on 1/2/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func ISO8601Formatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }
    
    static func blogPostDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMM, yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }

    static func eventMonthDayFormatter(timeZone: TimeZone) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM,dd,yyyy"
        dateFormatter.timeZone = timeZone
        return dateFormatter
    }
    
    static func formattedEventDateComponents(from date: Date, timeZone: TimeZone) -> (day: String, month: String, year: String) {
        let formattedDate = eventMonthDayFormatter(timeZone: timeZone).string(from: date)
        let dateComponents = formattedDate.components(separatedBy: ",")
        var eventDay: String = ""
        var eventMonth: String = ""
        var eventYear: String = ""
        
        if dateComponents.count > 2 {
            eventMonth = dateComponents[0]
            eventDay = dateComponents[1]
            eventYear = dateComponents[2]
        }

        return (day: eventDay, month: eventMonth, year: eventYear)
    }
}
