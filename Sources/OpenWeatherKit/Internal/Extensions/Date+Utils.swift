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
}
