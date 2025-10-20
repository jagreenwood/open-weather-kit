//
//  WeatherService.swift
//
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation
#if os(Linux)
import AsyncHTTPClient
import NIOCore
#endif
#if canImport(CoreLocation)
import CoreLocation
#endif

/// Provides an interface for obtaining weather data.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
final public class WeatherService: Sendable {

    /// Establishes the configuration for weather requests.
    @available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
    public struct Configuration: Sendable {

        public enum Language: String, Sendable {
            case englishUS = "en_US"
            case germanDE = "de_DE"
        }

        public var jwt: @Sendable () -> String
        public var language: Language

        /// Initializes an instance of Configuation
        /// - Parameters:
        ///   - jwt: A closure to provide a JWT.
        ///   - language: A language to localize human readable strings.
        public init(
            jwt: @escaping @Sendable () -> String,
            language: WeatherService.Configuration.Language = .englishUS
        ) {
            self.jwt = jwt
            self.language = language
        }
    }

    @usableFromInline
    let configuration: Configuration

    @usableFromInline
    let networkClient: NetworkClient

#if canImport(CoreLocation)
    @usableFromInline
    let geocoder: Geocoder

    internal init(
        configuration: Configuration,
        networkClient: NetworkClient,
        geocoder: Geocoder
    ) {
        self.configuration = configuration
        self.networkClient = networkClient
        self.geocoder = geocoder
    }
#else
    internal init(
        configuration: Configuration,
        networkClient: NetworkClient
    ) {
        self.configuration = configuration
        self.networkClient = networkClient
    }
#endif

#if os(Linux)
    public init(configuration: Configuration) {
        self.configuration = configuration
        self.networkClient = NetworkClient(
            client: HTTPClient(eventLoopGroupProvider: .singleton)
        )
    }

    public func shutdown() async throws {
        try await networkClient.client.shutdown()
    }

#else
    public init(configuration: Configuration) {
        self.configuration = configuration
        self.networkClient = NetworkClient(
            client: URLSession.shared
        )
        self.geocoder = .live
    }
#endif

    /// The required attribution which includes a legal attribution page and Apple Weather mark.
    final public var attribution: WeatherAttribution {
        get {
            WeatherAttribution(
                serviceName: "Apple Weather",
                legalPageURL: URL(string: "https://weather-data.apple.com/legal-attribution.html")!,
                squareMarkURL: URL(string: "https://weather-data.apple.com/assets/branding/square-mark.png")!,
                combinedMarkDarkURL: URL(string: "https://weather-data.apple.com/assets/branding/combined-mark-dark.png")!,
                combinedMarkLightURL: URL(string: "https://weather-data.apple.com/assets/branding/combined-mark-light.png")!)
        }
    }

#if canImport(CoreLocation)
    ///
    /// Returns the weather forecast for the requested location. Includes all available weather data sets.
    /// - Parameter location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The aggregate weather.
    ///
    @inlinable
    final public func weather(for location: LocationProtocol) async throws -> Weather {
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }
        guard let timezoneIdentifier = try await geocoder.timezone(location), let timezone = TimeZone(identifier: timezoneIdentifier) else { throw WeatherError.timezone }

        return try await getWeather(location: location, countryCode: countryCode, timezone: timezone)
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
        try await getWeather(location: location, countryCode: countryCode, timezone: timezone, language: language)
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
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }
        guard let timezoneIdentifier = try await geocoder.timezone(location), let timezone = TimeZone(identifier: timezoneIdentifier) else { throw WeatherError.timezone }

        let _dataSet = dataSet.update(with: countryCode)

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: _dataSet,
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try _dataSet.result(proxy)
    }
#else
    @inlinable
    final public func weather<T>(
        for location: LocationProtocol,
        including dataSet: WeatherQuery<T>,
        timezone: TimeZone
    ) async throws -> T {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: dataSet,
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try dataSet.result(proxy)
    }
#endif

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
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }
        guard let timezoneIdentifier = try await geocoder.timezone(location), let timezone = TimeZone(identifier: timezoneIdentifier) else { throw WeatherError.timezone }

        let _dataSet1 = dataSet1.update(with: countryCode)
        let _dataSet2 = dataSet2.update(with: countryCode)

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: _dataSet1, _dataSet2,
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            _dataSet1.result(proxy),
            _dataSet2.result(proxy)
        )
    }
#else
    @inlinable
    final public func weather<T1, T2>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        timezone: TimeZone
    ) async throws -> (T1, T2) {
                let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: dataSet1, dataSet2,
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            dataSet1.result(proxy),
            dataSet2.result(proxy)
        )
    }
#endif

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
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }
        guard let timezoneIdentifier = try await geocoder.timezone(location), let timezone = TimeZone(identifier: timezoneIdentifier) else { throw WeatherError.timezone }

        let _dataSet1 = dataSet1.update(with: countryCode)
        let _dataSet2 = dataSet2.update(with: countryCode)
        let _dataSet3 = dataSet3.update(with: countryCode)

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: _dataSet1, _dataSet2, _dataSet3,
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            _dataSet1.result(proxy),
            _dataSet2.result(proxy),
            _dataSet3.result(proxy)
        )
    }
#else
    @inlinable
    final public func weather<T1, T2, T3>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        timezone: TimeZone
    ) async throws -> (T1, T2, T3) {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: dataSet1, dataSet2, dataSet3,
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            dataSet1.result(proxy),
            dataSet2.result(proxy),
            dataSet3.result(proxy)
        )
    }
#endif

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
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }
        guard let timezoneIdentifier = try await geocoder.timezone(location), let timezone = TimeZone(identifier: timezoneIdentifier) else { throw WeatherError.timezone }

        let _dataSet1 = dataSet1.update(with: countryCode)
        let _dataSet2 = dataSet2.update(with: countryCode)
        let _dataSet3 = dataSet3.update(with: countryCode)
        let _dataSet4 = dataSet4.update(with: countryCode)
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: _dataSet1, _dataSet2, _dataSet3, _dataSet4,
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
#else
    @inlinable
    final public func weather<T1, T2, T3, T4>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        timezone: TimeZone
    ) async throws -> (T1, T2, T3, T4) {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: dataSet1, dataSet2, dataSet3, dataSet4,
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            dataSet1.result(proxy),
            dataSet2.result(proxy),
            dataSet3.result(proxy),
            dataSet4.result(proxy)
        )
    }
#endif

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
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }
        guard let timezoneIdentifier = try await geocoder.timezone(location), let timezone = TimeZone(identifier: timezoneIdentifier) else { throw WeatherError.timezone }

        let _dataSet1 = dataSet1.update(with: countryCode)
        let _dataSet2 = dataSet2.update(with: countryCode)
        let _dataSet3 = dataSet3.update(with: countryCode)
        let _dataSet4 = dataSet4.update(with: countryCode)
        let _dataSet5 = dataSet5.update(with: countryCode)

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: _dataSet1, _dataSet2, _dataSet3, _dataSet4, _dataSet5,
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
#else
    @inlinable
    final public func weather<T1, T2, T3, T4, T5>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        _ dataSet5: WeatherQuery<T5>,
        timezone: TimeZone
    ) async throws -> (T1, T2, T3, T4, T5) {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: dataSet1, dataSet2, dataSet3, dataSet4, dataSet5,
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            dataSet1.result(proxy),
            dataSet2.result(proxy),
            dataSet3.result(proxy),
            dataSet4.result(proxy),
            dataSet5.result(proxy)
        )
    }
#endif

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
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }
        guard let timezoneIdentifier = try await geocoder.timezone(location), let timezone = TimeZone(identifier: timezoneIdentifier) else { throw WeatherError.timezone }

        let _dataSet1 = dataSet1.update(with: countryCode)
        let _dataSet2 = dataSet2.update(with: countryCode)
        let _dataSet3 = dataSet3.update(with: countryCode)
        let _dataSet4 = dataSet4.update(with: countryCode)
        let _dataSet5 = dataSet5.update(with: countryCode)
        let _dataSet6 = dataSet6.update(with: countryCode)

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: _dataSet1, _dataSet2, _dataSet3, _dataSet4, _dataSet5, _dataSet6,
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
#else
    @inlinable
    final public func weather<T1, T2, T3, T4, T5, T6>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        _ dataSet5: WeatherQuery<T5>,
        _ dataSet6: WeatherQuery<T6>,
        timezone: TimeZone
    ) async throws -> (T1, T2, T3, T4, T5, T6) {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: self.configuration.language,
            queries: dataSet1, dataSet2, dataSet3, dataSet4, dataSet5, dataSet6,
            timezone: timezone,
            jwt: self.configuration.jwt()
        )

        return try (
            dataSet1.result(proxy),
            dataSet2.result(proxy),
            dataSet3.result(proxy),
            dataSet4.result(proxy),
            dataSet5.result(proxy),
            dataSet6.result(proxy)
        )
    }
#endif
}

extension WeatherService {
    @usableFromInline
    func getWeather(location: LocationProtocol, countryCode: String, timezone: TimeZone, language: WeatherService.Configuration.Language? = nil) async throws -> Weather {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: language ?? self.configuration.language,
            queries: WeatherQuery<CurrentWeather>.current,
                WeatherQuery<Forecast<MinuteWeather>?>.minute,
                WeatherQuery<Forecast<HourWeather>>.hourly,
                WeatherQuery<Forecast<DayWeather>>.daily,
                WeatherQuery<[WeatherAlert]?>.alerts(countryCode: countryCode),
                WeatherQuery<WeatherAvailability>.availability(countryCode: countryCode),
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
