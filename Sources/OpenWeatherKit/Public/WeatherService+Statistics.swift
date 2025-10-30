//
//  WeatherService+Statistics.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/30/25.
//

import Foundation

// MARK: - Statistics
extension WeatherService {
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
    final public func dailyStatistics<each T>(
        for location: LocationProtocol,
        startDay: Int,
        endDay: Int,
        including: repeat DailyWeatherStatisticsQuery<each T>
    ) async throws -> (repeat DailyWeatherStatistics<each T>) {
        // Validate day range
        guard (1...366).contains(startDay) && (1...366).contains(endDay) && startDay <= endDay else {
            throw WeatherError.invalidRequest("Day range must be between 1-366 and startDay must be <= endDay")
        }

        let statistics = try await networkClient.fetchDailyStatistics(
            location: location,
            dataSets: repeat each including,
            startDay: startDay,
            endDay: endDay,
            jwt: configuration.jwt()
        )

        return (repeat statistics.parse(query: each including))
    }

    ///
    /// Returns daily weather statistics for the requested location, for each day within the specified date interval.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    ///   - interval: The date interval for which to obtain daily weather statistics. The end date of the interval will be capped at 1 year after the start date.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested daily weather statistics.
    ///
    /// The statistics returned for each day are derived from weather data recorded over the past decades, to the present date. Each item returned represents statistics for a particular day of the year, in UTC. For example, if December 31, UTC time, is within the span, the statistics returned for that particular day will be taken from data recorded over the years for day 365 of the year, or 366 if December 31 of the span falls on a leap year.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple. Here's an example:
    ///
    /// ```
    /// let (dailyPrecipitationStatistics, dailyTemperatureStatistics) = try await service.dailyStatistics(for: newYork, forDaysIn: timeInterval, including: .precipitation, .temperature)
    /// ```
    ///
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func dailyStatistics<each T>(
        for location: LocationProtocol,
        forDaysIn interval: DateInterval,
        including: repeat DailyWeatherStatisticsQuery<each T>
    ) async throws -> (repeat DailyWeatherStatistics<each T>) {
        // Convert DateInterval to day of year
        let calendar = Calendar.current
        let startDay = calendar.ordinality(of: .day, in: .year, for: interval.start) ?? 1
        let endDay = calendar.ordinality(of: .day, in: .year, for: interval.end) ?? 366

        return try await dailyStatistics(
            for: location,
            startDay: startDay,
            endDay: endDay,
            including: repeat each including
        )
    }

    ///
    /// Returns daily weather statistics for the requested location, for each day between 30 days ago and 10 days from now.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested daily weather statistics.
    ///
    /// The statistics returned for each day are derived from weather data recorded over the past decades, to the present date. Each item returned represents statistics for a particular day of the year, in UTC. For example, if December 31, UTC time, is within the span, the statistics returned for that particular day will be taken from data recorded over the years for day 365 of the year, or 366 if December 31 of the span falls on a leap year.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple. Here's an example:
    ///
    /// ```
    /// let (dailyPrecipitationStatistics, dailyTemperatureStatistics) = try await service.dailyStatistics(for: newYork, including: .precipitation, .temperature)
    /// ```
    ///
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func dailyStatistics<each T>(
        for location: LocationProtocol,
        including: repeat DailyWeatherStatisticsQuery<each T>
    ) async throws -> (repeat DailyWeatherStatistics<each T>) {
        let now = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -30, to: now) ?? now.addingTimeInterval(-30 * 24 * 60 * 60)
        let endDate = calendar.date(byAdding: .day, value: 10, to: now) ?? now.addingTimeInterval(10 * 24 * 60 * 60)
        let interval = DateInterval(start: startDate, end: endDate)

        return try await dailyStatistics(
            for: location,
            forDaysIn: interval,
            including: repeat each including
        )
    }

    ///
    /// Returns hourly weather statistics for the requested location, for each hour from the start hour to the end hour, inclusively.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    ///   - startHour: The first hour of the span, between 1 and 8784.
    ///   - endHour: The last hour of the span, between 1 and 8784.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested hourly weather statistics.
    ///
    /// The statistics returned for each hour are derived from weather data recorded over the past decades, to the present date. Each item returned represents statistics for a particular hour of the year, in UTC.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple.
    /// The following example will return statistics for the first 24 hours of the year.
    ///
    /// ```swift
    /// let hourlyTemperatureStatistics = try await service.hourlyStatistics(for: newYork, startHour: 1, endHour: 24, including: .temperature)
    /// ```
    ///
    /// If the start hour is greater than the end hour, then a wrap around will occur. This next example will return statistics for hours 8783, 8784, 1, and 2.
    ///
    /// ```swift
    /// let hourlyTemperatureStatistics = try await service.hourlyStatistics(for: newYork, startHour: 8783, endHour: 2, including: .temperature)
    /// ```
    ///
    /// - Precondition: `startHour in 1...8784 && endHour in 1...8784`
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func hourlyStatistics<each T>(
        for location: LocationProtocol,
        startHour: Int,
        endHour: Int,
        including: repeat HourlyWeatherStatisticsQuery<each T>
    ) async throws -> (repeat HourlyWeatherStatistics<each T>) {
        // Validate hour range
        guard (1...8784).contains(startHour) && (1...8784).contains(endHour) && startHour <= endHour else {
            throw WeatherError.invalidRequest("Hour range must be between 1-8784 and startHour must be <= endHour")
        }

        let statistics = try await networkClient.fetchHourlyStatistics(
            location: location,
            dataSets: repeat each including,
            startHour: startHour,
            endHour: endHour,
            jwt: configuration.jwt()
        )

        return (repeat statistics.parse(query: each including))
    }

    ///
    /// Returns hourly weather statistics for the requested location, for each hour within the specified date interval.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    ///   - interval: The date interval for which to obtain hourly weather statistics.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested hourly weather statistics.
    ///
    /// The statistics returned for each hour are derived from weather data recorded over the past decades, to the present date. Each item returned represents statistics for a particular hour of the year, in UTC. For example, if the hours of December 31, UTC time, are within the span, the statistics returned for those particular hours will be taken from data recorded over the years for hours 8737 to 8760 of the year, or 8761 to 8784 if December 31 of the span falls on a leap year.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple. Here's an example:
    ///
    /// ```swift
    /// let hourlyTemperatureStatistics = try await service.hourlyStatistics(for: newYork, forHoursIn: interval, including: .temperature)
    /// ```
    ///
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func hourlyStatistics<each T>(
        for location: LocationProtocol,
        forHoursIn interval: DateInterval,
        including: repeat HourlyWeatherStatisticsQuery<each T>
    ) async throws -> (repeat HourlyWeatherStatistics<each T>) {
        // Convert DateInterval to hour of year
        let calendar = Calendar.current
        let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: interval.start))!
        let startHour = calendar.dateComponents([.hour], from: startOfYear, to: interval.start).hour ?? 0
        let endHour = calendar.dateComponents([.hour], from: startOfYear, to: interval.end).hour ?? 8783

        return try await hourlyStatistics(
            for: location,
            startHour: max(1, startHour + 1),
            endHour: min(8784, endHour + 1),
            including: repeat each including
        )
    }

    ///
    /// Returns hourly weather statistics for the requested location, for the 24 hours of the current day.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    ///   - interval: The date interval for which to obtain hourly weather statistics.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested hourly weather statistics.
    ///
    /// The statistics returned for each hour are derived from weather data recorded over the past decades, to the present date. Each item returned represents statistics for a particular hour of the year, in UTC. For example, if the hours of December 31, UTC time, are within the span, the statistics returned for those particular hours will be taken from data recorded over the years for hours 8737 to 8760 of the year, or 8761 to 8784 if December 31 of the span falls on a leap year.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple. Here's an example:
    ///
    /// ```swift
    /// let hourlyTemperatureStatistics = try await service.hourlyStatistics(for: newYork, including: .temperature)
    /// ```
    ///
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func hourlyStatistics<each T>(
        for location: LocationProtocol,
        including: repeat HourlyWeatherStatisticsQuery<each T>
    ) async throws -> (repeat HourlyWeatherStatistics<each T>) {
        let now = Date()
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: now)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) ?? startOfDay.addingTimeInterval(24 * 60 * 60)
        let interval = DateInterval(start: startOfDay, end: endOfDay)

        return try await hourlyStatistics(
            for: location,
            forHoursIn: interval,
            including: repeat each including
        )
    }

    ///
    /// Returns monthly weather statistics for the requested location, for each month from the start month to the end month, inclusively.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    ///   - startMonth: The first month of the span, between 1 and 12.
    ///   - endMonth: The last month of the span, between 1 and 12.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested monthly weather statistics.
    ///
    /// The statistics returned for each month are derived from weather data recorded over the past decades, to the present date. Each item returned represents statistics for a particular Gregorian Calendar month of the year.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple.
    /// The following example will return statistics for all months of the year.
    ///
    /// ```swift
    /// let (monthlyPrecipitationStatistics, monthlyTemperatureStatistics) = try await service.monthlyStatistics(for: newYork, startMonth: 1, endMonth: 12, including: .precipitation, .temperature)
    /// ```
    ///
    /// If `start` comes after `end` in the year, then a wrap around will occur. This next example will return statistics for months 11, 12, 1, and 2.
    ///
    /// ```swift
    /// let (monthlyPrecipitationStatistics, monthlyTemperatureStatistics) = try await service.monthlyStatistics(for: newYork, startMonth: 11, endMonth: 2, including: .precipitation, .temperature)
    /// ```
    ///
    /// - Precondition: `startMonth in 1...12 && endMonth in 1...12`
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func monthlyStatistics<each T>(
        for location: LocationProtocol,
        startMonth: Int,
        endMonth: Int,
        including: repeat MonthlyWeatherStatisticsQuery<each T>
    ) async throws -> (repeat MonthlyWeatherStatistics<each T>) {
        // Validate month range
        guard (1...12).contains(startMonth) && (1...12).contains(endMonth) && startMonth <= endMonth else {
            throw WeatherError.invalidRequest("Month range must be between 1-12 and startMonth must be <= endMonth")
        }

        let statistics = try await networkClient.fetchMonthlyStatistics(
            location: location,
            dataSets: repeat each including,
            startMonth: startMonth,
            endMonth: endMonth,
            jwt: configuration.jwt()
        )

        return (repeat statistics.parse(query: each including))
    }

    ///
    /// Returns monthly weather statistics for the requested location, for each month within the specified date interval.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    ///   - interval: The date interval for which to obtain monthly weather statistics. The end date of the interval will be capped at 1 year after the start date.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested monthly weather statistics.
    ///
    /// The statistics returned for each month are derived from weather data recorded over the past decades, to the present date. Each item returned represents statistics for a particular Gregorian Calendar month of the year.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple. Here's an example:
    ///
    /// ```swift
    /// let (monthlyPrecipitationStatistics, monthlyTemperatureStatistics) = try await service.monthlyStatistics(for: newYork, forMonthsIn: interval, including: .precipitation, .temperature)
    /// ```
    ///
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func monthlyStatistics<each T>(
        for location: LocationProtocol,
        forMonthsIn interval: DateInterval,
        including: repeat MonthlyWeatherStatisticsQuery<each T>
    ) async throws -> (repeat MonthlyWeatherStatistics<each T>) {
        // Convert DateInterval to month range
        let calendar = Calendar.current
        let startMonth = calendar.component(.month, from: interval.start)
        let endMonth = calendar.component(.month, from: interval.end)

        return try await monthlyStatistics(
            for: location,
            startMonth: startMonth,
            endMonth: endMonth,
            including: repeat each including
        )
    }

    ///
    /// Returns monthly weather statistics for the requested location, for all 12 months of the Gregorian calendar year.
    ///
    /// - Parameters:
    ///   - location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested monthly weather statistics
    ///
    /// The statistics returned for each month are derived from weather data recorded over the past decades, to the present date. Each item returned represents statistics for a particular Gregorian Calendar month of the year.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple. Here's an example:
    ///
    /// ```swift
    /// let (monthlyPrecipitationStatistics, monthlyTemperatureStatistics) = try await service.monthlyStatistics(for: newYork, including: .precipitation, .temperature)
    /// ```
    ///
    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @inlinable
    final public func monthlyStatistics<each T>(
        for location: LocationProtocol,
        including: repeat MonthlyWeatherStatisticsQuery<each T>
    ) async throws -> (repeat MonthlyWeatherStatistics<each T>) {
        try await monthlyStatistics(
            for: location,
            startMonth: 1,
            endMonth: 12,
            including: repeat each including
        )
    }

}
