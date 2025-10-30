//
//  WeatherService+Summary.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/30/25.
//

import Foundation

// MARK: - Daily Summary
extension WeatherService {
    
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

    ///
    /// Returns daily weather statistics for the requested location, for each day from the start day to the end day, inclusively.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    ///   - startDay: The first day of the span, between 1 and 366.
    ///   - endDay: The last day of the span, between 1 and 366.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested daily weather statistics
    ///
    /// The statistics returned for each day are derived from weather data recorded over the past decades, to the present date. Each item returned represents statistics for a particular day of the year, in UTC.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple. The following example will return statistics for the first 10 days of the year.
    ///
    /// ```
    /// let (dailyPrecipitationStatistics, dailyTemperatureStatistics) = try await service.dailyStatistics(for: newYork, startDay: 1, endDay: 10, including: .precipitation, .temperature)
    /// ```
    ///
    /// If `startDay` is greater than `endDay`, then a wrap around will occur. This next example will return statistics for days 365, 366, 1, and 2.
    ///
    /// ```swift
    /// let (dailyPrecipitationStatistics, dailyTemperatureStatistics) = try await service.dailyStatistics(for: newYork, startDay: 365, endDay: 2, including: .precipitation, .temperature)
    /// ```
    ///
    /// - Precondition: `startDay in 1...366 && endDay in 1...366`
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func dailySummary<each T>(
        for location: LocationProtocol,
        startDay: Int,
        endDay: Int,
        including: repeat DailyWeatherSummaryQuery<each T>
    ) async throws -> (repeat DailyWeatherSummary<each T>) {
        // Use a UTC Gregorian calendar to interpret day-of-year in UTC
        var calendar = Calendar(identifier: .gregorian)
        guard let utcTimeZone = TimeZone(secondsFromGMT: 0) else {
            throw WeatherError.invalidRequest("Unable to create UTC timezone")
        }
        calendar.timeZone = utcTimeZone

        let now = Date()
        let currentYear = calendar.component(.year, from: now)

        // Compute the date range
        let (startDate, endDate) = try Self.computeDateRange(
            startDay: startDay,
            endDay: endDay,
            calendar: calendar,
            referenceYear: currentYear
        )

        // Build interval and delegate to date-interval overload; header docs note end is capped at 1 year after start
        let interval = DateInterval(start: startDate, end: endDate)
        return try await dailySummary(
            for: location,
            forDaysIn: interval,
            including: repeat each including
        )
    }

    ///
    /// Returns day weather summaries for the requested location, for each day within the provided date interval.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    ///   - interval: The date interval for which to obtain day weather summaries. The end date of the interval will be capped at 1 year after the start date.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested day weather summaries.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple. The following example will get a daily weather summary for New York City.
    ///
    /// ```swift
    /// let (dailyPrecipitationSummary, dailyTemperatureSummary) = try await service.dailySummary(for: newYork, forDaysIn: timeInterval, including: .precipitation, .temperature)
    /// ```
    ///
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func dailySummary<each T>(
        for location: LocationProtocol,
        forDaysIn interval: DateInterval,
        including: repeat DailyWeatherSummaryQuery<each T>
    ) async throws -> (repeat DailyWeatherSummary<each T>) {
        // Validate interval and cap the end date to 1 year after the start date
        guard interval.end >= interval.start else {
            throw WeatherError.invalidRequest("End date must not be earlier than start date")
        }

        // Use consistent calendar for date calculations
        var calendar = Calendar(identifier: .gregorian)
        guard let utcTimeZone = TimeZone(secondsFromGMT: 0) else {
            throw WeatherError.invalidRequest("Unable to create UTC timezone")
        }
        calendar.timeZone = utcTimeZone

        let oneYearAfterStart = calendar.date(byAdding: .year, value: 1, to: interval.start) ?? interval.end
        let cappedEndDate = min(interval.end, oneYearAfterStart)

        let summary = try await networkClient.fetchDailySummary(
            location: location,
            dataSets: repeat each including,
            startDate: interval.start,
            endDate: cappedEndDate,
            jwt: configuration.jwt()
        )

        return (repeat summary.parse(query: each including))
    }


    ///
    /// Returns day weather summaries for the requested location, for the past 30 days, including the present day.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested day weather summaries.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple. The following example will get a daily weather summary for New York City.
    ///
    /// ```swift
    /// let (dailyPrecipitationSummary, dailyTemperatureSummary) = try await service.dailySummary(for: newYork, including: .precipitation, .temperature)
    /// ```
    ///
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func dailySummary<each T>(
        for location: LocationProtocol,
        including: repeat DailyWeatherSummaryQuery<each T>
    ) async throws -> (repeat DailyWeatherSummary<each T>) {
        // Build a 30-day interval ending today (including the present day)
        let endDate = Date()
        
        // Use consistent calendar for date calculations
        var calendar = Calendar(identifier: .gregorian)
        guard let utcTimeZone = TimeZone(secondsFromGMT: 0) else {
            throw WeatherError.invalidRequest("Unable to create UTC timezone")
        }
        calendar.timeZone = utcTimeZone
        
        guard let startDate = calendar.date(byAdding: .day, value: -30, to: endDate) else {
            throw WeatherError.invalidRequest("Unable to compute 30-day interval")
        }

        let interval = DateInterval(start: startDate, end: endDate)
        return try await dailySummary(
            for: location,
            forDaysIn: interval,
            including: repeat each including
        )
    }
}

