//
//  WeatherService+Forecast.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/30/25.
//

import Foundation
#if canImport(CoreLocation)
import CoreLocation
#endif

extension WeatherService {
#if canImport(CoreLocation)
    ///
    /// Returns the weather forecast for the requested location. Includes all available weather data sets.
    /// - Parameter location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The aggregate weather.
    ///
    @inlinable
    final public func weather(for location: LocationProtocol) async throws -> Weather {
        let (countryCode, timezone) = try await resolveCountryCodeAndTimezone(for: location)
        return try await getWeather(
            location: location,
            countryCode: countryCode,
            timezone: timezone
        )
    }
#endif

    ///
    /// Returns the weather forecast for the requested location. Includes all available weather data sets.
    /// - Parameter location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The aggregate weather.
    ///
    @inlinable
    final public func weather(
        for location: LocationProtocol,
        countryCode: String,
        timezone: TimeZone,
        language: WeatherService.Configuration.Language? = nil
    ) async throws -> Weather {
        try await getWeather(
            location: location,
            countryCode: countryCode,
            timezone: timezone,
            language: language
        )
    }

    ///
    /// Returns the weather forecast for the requested location.
    /// - Parameters:
    ///    - location: The requested location.
    ///    - including: Weather query
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested weather data set.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple.
    ///
    /// Example usage:
    /// `let current = try await service.weather(for: newYork, including: .current)`
    ///
#if canImport(CoreLocation)
    @inlinable
    final public func weather<T>(
        for location: LocationProtocol,
        including dataSet: WeatherQuery<T>
    ) async throws -> T {
        let (countryCode, timezone) = try await resolveCountryCodeAndTimezone(for: location)
        return try await weather(
            for: location,
            including: dataSet,
            countryCode: countryCode,
            timezone: timezone
        )
    }
#endif

    @inlinable
    final public func weather<T>(
        for location: LocationProtocol,
        including dataSet: WeatherQuery<T>,
        countryCode: String? = nil,
        timezone: TimeZone
    ) async throws -> T {
        let _dataSet = countryCode.map { dataSet.update(with: $0) } ?? dataSet

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: [_dataSet],
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try _dataSet.result(proxy)
    }

    ///
    /// Returns the weather forecast for the requested location.
    /// - Parameters:
    ///    - location: The requested location.
    ///    - including: Weather queries
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested weather data set.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple.
    ///
    /// Example usage:
    /// `let (current, minute) = try await service.weather(for: newYork, including: .current, .minute)`
    ///
#if canImport(CoreLocation)
    @inlinable
    final public func weather<T1, T2>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>
    ) async throws -> (T1, T2) {
        let (countryCode, timezone) = try await resolveCountryCodeAndTimezone(for: location)
        return try await weather(
            for: location,
            including: dataSet1, dataSet2,
            countryCode: countryCode,
            timezone: timezone
        )
    }
#endif

    @inlinable
    final public func weather<T1, T2>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        countryCode: String? = nil,
        timezone: TimeZone
    ) async throws -> (T1, T2) {
        let _dataSet1 = countryCode.map { dataSet1.update(with: $0) } ?? dataSet1
        let _dataSet2 = countryCode.map { dataSet2.update(with: $0) } ?? dataSet2

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: [_dataSet1, _dataSet2],
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            _dataSet1.result(proxy),
            _dataSet2.result(proxy)
        )
    }

    ///
    /// Returns the weather forecast for the requested location.
    /// - Parameters:
    ///    - location: The requested location.
    ///    - including: Weather queries
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested weather data set.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple.
    ///
#if canImport(CoreLocation)
    @inlinable
    final public func weather<T1, T2, T3>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>
    ) async throws -> (T1, T2, T3) {
        let (countryCode, timezone) = try await resolveCountryCodeAndTimezone(for: location)
        return try await weather(
            for: location,
            including: dataSet1, dataSet2, dataSet3,
            countryCode: countryCode,
            timezone: timezone
        )
    }
#endif

    @inlinable
    final public func weather<T1, T2, T3>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        countryCode: String? = nil,
        timezone: TimeZone
    ) async throws -> (T1, T2, T3) {
        let _dataSet1 = countryCode.map { dataSet1.update(with: $0) } ?? dataSet1
        let _dataSet2 = countryCode.map { dataSet2.update(with: $0) } ?? dataSet2
        let _dataSet3 = countryCode.map { dataSet3.update(with: $0) } ?? dataSet3

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: [_dataSet1, _dataSet2, _dataSet3],
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            _dataSet1.result(proxy),
            _dataSet2.result(proxy),
            _dataSet3.result(proxy)
        )
    }

    ///
    /// Returns the weather forecast for the requested location.
    /// - Parameters:
    ///    - location: The requested location.
    ///    - including: Weather queries
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested weather data set.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple.
    ///
#if canImport(CoreLocation)
    @inlinable
    final public func weather<T1, T2, T3, T4>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>
    ) async throws -> (T1, T2, T3, T4) {
        let (countryCode, timezone) = try await resolveCountryCodeAndTimezone(for: location)
        return try await weather(
            for: location,
            including: dataSet1, dataSet2, dataSet3, dataSet4,
            countryCode: countryCode,
            timezone: timezone
        )
    }
#endif

    @inlinable
    final public func weather<T1, T2, T3, T4>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        countryCode: String? = nil,
        timezone: TimeZone
    ) async throws -> (T1, T2, T3, T4) {
        let _dataSet1 = countryCode.map { dataSet1.update(with: $0) } ?? dataSet1
        let _dataSet2 = countryCode.map { dataSet2.update(with: $0) } ?? dataSet2
        let _dataSet3 = countryCode.map { dataSet3.update(with: $0) } ?? dataSet3
        let _dataSet4 = countryCode.map { dataSet4.update(with: $0) } ?? dataSet4

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: [_dataSet1, _dataSet2, _dataSet3, _dataSet4],
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            _dataSet1.result(proxy),
            _dataSet2.result(proxy),
            _dataSet3.result(proxy),
            _dataSet4.result(proxy)
        )
    }

    ///
    /// Returns the weather forecast for the requested location.
    /// - Parameters:
    ///    - location: The requested location.
    ///    - including: Weather queries
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested weather data set.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple.
    ///
#if canImport(CoreLocation)
    @inlinable
    final public func weather<T1, T2, T3, T4, T5>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        _ dataSet5: WeatherQuery<T5>
    ) async throws -> (T1, T2, T3, T4, T5) {
        let (countryCode, timezone) = try await resolveCountryCodeAndTimezone(for: location)
        return try await weather(
            for: location,
            including: dataSet1, dataSet2, dataSet3, dataSet4, dataSet5,
            countryCode: countryCode,
            timezone: timezone
        )
    }
#endif

    @inlinable
    final public func weather<T1, T2, T3, T4, T5>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        _ dataSet5: WeatherQuery<T5>,
        countryCode: String? = nil,
        timezone: TimeZone
    ) async throws -> (T1, T2, T3, T4, T5) {
        let _dataSet1 = countryCode.map { dataSet1.update(with: $0) } ?? dataSet1
        let _dataSet2 = countryCode.map { dataSet2.update(with: $0) } ?? dataSet2
        let _dataSet3 = countryCode.map { dataSet3.update(with: $0) } ?? dataSet3
        let _dataSet4 = countryCode.map { dataSet4.update(with: $0) } ?? dataSet4
        let _dataSet5 = countryCode.map { dataSet5.update(with: $0) } ?? dataSet5

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: [_dataSet1, _dataSet2, _dataSet3, _dataSet4, _dataSet5],
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            _dataSet1.result(proxy),
            _dataSet2.result(proxy),
            _dataSet3.result(proxy),
            _dataSet4.result(proxy),
            _dataSet5.result(proxy)
        )
    }

    ///
    /// Returns the weather forecast for the requested location.
    /// - Parameters:
    ///    - location: The requested location.
    ///    - including: Weather queries
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested weather data set.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple.
    ///
#if canImport(CoreLocation)
    @inlinable
    final public func weather<T1, T2, T3, T4, T5, T6>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        _ dataSet5: WeatherQuery<T5>,
        _ dataSet6: WeatherQuery<T6>
    ) async throws -> (T1, T2, T3, T4, T5, T6) {
        let (countryCode, timezone) = try await resolveCountryCodeAndTimezone(for: location)
        return try await weather(
            for: location,
            including: dataSet1, dataSet2, dataSet3, dataSet4, dataSet5, dataSet6,
            countryCode: countryCode,
            timezone: timezone
        )
    }
#endif

    @inlinable
    final public func weather<T1, T2, T3, T4, T5, T6>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        _ dataSet5: WeatherQuery<T5>,
        _ dataSet6: WeatherQuery<T6>,
        countryCode: String? = nil,
        timezone: TimeZone
    ) async throws -> (T1, T2, T3, T4, T5, T6) {
        let _dataSet1 = countryCode.map { dataSet1.update(with: $0) } ?? dataSet1
        let _dataSet2 = countryCode.map { dataSet2.update(with: $0) } ?? dataSet2
        let _dataSet3 = countryCode.map { dataSet3.update(with: $0) } ?? dataSet3
        let _dataSet4 = countryCode.map { dataSet4.update(with: $0) } ?? dataSet4
        let _dataSet5 = countryCode.map { dataSet5.update(with: $0) } ?? dataSet5
        let _dataSet6 = countryCode.map { dataSet6.update(with: $0) } ?? dataSet6

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: [_dataSet1, _dataSet2, _dataSet3, _dataSet4, _dataSet5, _dataSet6],
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            _dataSet1.result(proxy),
            _dataSet2.result(proxy),
            _dataSet3.result(proxy),
            _dataSet4.result(proxy),
            _dataSet5.result(proxy),
            _dataSet6.result(proxy)
        )
    }

    ///
    /// Returns the weather forecast for the requested location.
    ///
    /// - Parameter location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested weather data set.
    ///
    /// This is a variadic API in which any combination of data sets can be requested and returned as a tuple. Here's an example:
    ///
    /// ```
    /// `let (current, minute, hourly, daily, alerts) = try await service.weather(for: newYork, including: .current, .minute, .hourly, .daily, .alerts)`
    /// ```
#if canImport(CoreLocation)
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
    @preconcurrency final public func weather<each T>(
        for location: CLLocation,
        including dataSet: repeat WeatherQuery<each T>
    ) async throws -> (repeat each T) {
        let (countryCode, timezone) = try await resolveCountryCodeAndTimezone(for: location)
        return try await weather(
            for: location,
            including: repeat each dataSet,
            countryCode: countryCode,
            timezone: timezone
        )
    }
#endif

    @available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
    @preconcurrency final public func weather<each T>(
        for location: CLLocation,
        including dataSets: repeat WeatherQuery<each T>,
        countryCode: String? = nil,
        timezone: TimeZone
    ) async throws -> (repeat each T) {
        // Materialize the pack to a mutable variable to allow conditional mutation
        var _dataSets = (repeat each dataSets)
        // If a country code is provided, update each query with the country code for region-specific data
        if let countryCode {
            _dataSets = (repeat (each dataSets).update(with: countryCode))
        }

        // The network client's fetchWeather method expects an array, so convert the pack into an array
        var queries: [any Query] = []
        repeat queries.append((each _dataSets)) // Pack expansion into the array

        // Perform the network fetch with all queries batched together
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: queries,
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        // Expand the pack to extract the typed results from the proxy for each query
        return (repeat try (each _dataSets).result(proxy))
    }
}

extension WeatherService {
#if canImport(CoreLocation)
    @usableFromInline
    func resolveCountryCodeAndTimezone(for location: LocationProtocol) async throws -> (countryCode: String, timezone: TimeZone) {
        guard let countryCode = try await geocoder.countryCode(location) else {
            throw WeatherError.countryCode
        }
        guard let timezoneIdentifier = try await geocoder.timezone(location),
              let timezone = TimeZone(identifier: timezoneIdentifier) else {
            throw WeatherError.timezone
        }
        return (countryCode, timezone)
    }
#endif

    @usableFromInline
    func getWeather(
        location: LocationProtocol,
        countryCode: String,
        timezone: TimeZone,
        language: WeatherService.Configuration.Language? = nil
    ) async throws -> Weather {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: language ?? self.configuration.language,
            queries: [
                WeatherQuery<CurrentWeather>.current,
                WeatherQuery<Forecast<MinuteWeather>?>.minute,
                WeatherQuery<Forecast<HourWeather>>.hourly,
                WeatherQuery<Forecast<DayWeather>>.daily,
                WeatherQuery<[WeatherAlert]?>.alerts(countryCode: countryCode),
                WeatherQuery<WeatherAvailability>.availability(countryCode: countryCode)
            ],
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try Weather(
            currentWeather: proxy.currentWeather.unwrap(
                or: WeatherError.missingData(APIWeather.CodingKeys.currentWeather.rawValue)
            ),
            minuteForecast: proxy.minuteForecast,
            hourlyForecast: proxy.hourlyForecast.unwrap(
                or: WeatherError.missingData(APIWeather.CodingKeys.forecastHourly.rawValue)
            ),
            dailyForecast: proxy.dailyForecast.unwrap(
                or: WeatherError.missingData(APIWeather.CodingKeys.forecastDaily.rawValue)
            ),
            weatherAlerts: proxy.weatherAlerts,
            availability: proxy.availability.unwrap(
                or: WeatherError.missingData(QueryContants.availability)
            )
        )
    }
}

