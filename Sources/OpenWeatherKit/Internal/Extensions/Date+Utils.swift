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

    /// Computes start and end dates for a day-of-year range, handling wrap-around scenarios.
    ///
    /// - Parameters:
    ///   - startDay: The first day of the span, between 1 and 366.
    ///   - endDay: The last day of the span, between 1 and 366.
    ///   - calendar: The calendar to use for date calculations (should be UTC).
    ///   - referenceYear: The reference year to use for date calculations.
    /// - Throws: `WeatherError.invalidRequest` if dates cannot be computed.
    /// - Returns: A tuple containing the start and end dates for the range.
    ///
    /// For normal cases where `endDay >= startDay`, both dates use the reference year.
    /// For wrap-around cases where `startDay > endDay`, the start date uses `referenceYear - 1`
    /// and the end date uses `referenceYear`, allowing for ranges like "Dec 31 to Jan 2".
    ///
    /// Example: `startDay: 365, endDay: 2` with `referenceYear: 2024` returns:
    /// - Start: December 31, 2023
    /// - End: January 2, 2024
    @usableFromInline
    static func computeDateRange(
        startDay: Int,
        endDay: Int,
        calendar: Calendar,
        referenceYear: Int
    ) throws -> (startDate: Date, endDate: Date) {
        guard (1...366).contains(startDay), (1...366).contains(endDay) else {
            throw WeatherError.invalidRequest("startDay and endDay must be within 1...366")
        }

        // Helper to compute a concrete Date from a day-of-year and year
        func dateFor(dayOfYear: Int, year: Int) throws -> Date {
            guard let startOfYear = calendar.date(from: DateComponents(year: year, month: 1, day: 1)) else {
                throw WeatherError.invalidRequest("Unable to create start of year date for year \(year)")
            }

            // Check if the requested day exists in the given year
            let daysInYear = calendar.range(of: .day, in: .year, for: startOfYear)?.count ?? 365
            guard dayOfYear <= daysInYear else {
                throw WeatherError.invalidRequest("Day \(dayOfYear) does not exist in year \(year)")
            }

            guard let result = calendar.date(byAdding: .day, value: dayOfYear - 1, to: startOfYear) else {
                throw WeatherError.invalidRequest("Unable to create date for day \(dayOfYear) in year \(year)")
            }
            return result
        }

        let startDate: Date
        let endDate: Date

        if endDay >= startDay {
            // Normal case: same year
            startDate = try dateFor(dayOfYear: startDay, year: referenceYear)
            endDate = try dateFor(dayOfYear: endDay, year: referenceYear)
        } else {
            // Wrap-around case: for historical data, this means spanning across year boundary
            // e.g., startDay: 365, endDay: 2 means Dec 31 (previous year) to Jan 2 (current year)
            startDate = try dateFor(dayOfYear: startDay, year: referenceYear - 1)
            endDate = try dateFor(dayOfYear: endDay, year: referenceYear)
        }

        return (startDate: startDate, endDate: endDate)
    }
}
