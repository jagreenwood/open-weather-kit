//
//  Date+Utils.swift
//  
//
//  Created by Jeremy Greenwood on 11/2/22.
//

import Foundation

extension Date {
    static func daysFromNow(_ days: Int) -> Date {
        var components = DateComponents()
        components.day = days
        return Calendar.current.date(byAdding: components, to: Date())!
    }

    static func hoursFromNow(_ hours: Int) -> Date {
        var components = DateComponents()
        components.hour = hours
        return Calendar.current.date(byAdding: components, to: Date())!
    }

    static func daysFromEpoch(_ days: Int) -> Date {
        // Create a date from the Unix epoch (1970-01-01)
        let epoch = Date(timeIntervalSince1970: 0)

        // Convert days to TimeInterval (seconds) and subtract 1 day since 1970-01-01 is day 1
        let timeInterval = TimeInterval((days - 1) * 24 * 60 * 60)
        return Date(timeInterval: timeInterval, since: epoch)
    }
}
