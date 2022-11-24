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

final public class WeatherService: Sendable {
    public struct Configuration: Sendable {
        public enum Language: Sendable {
            case englishUS

            var languageCode: String {
                switch self {
                case .englishUS: return "en_US"
                }
            }
        }

        public var jwt: @Sendable () -> String
        public var language: Language
#if os(Linux)
        public var eventLoopGroupProvider: NIOEventLoopGroupProvider

        public init(
            jwt: @escaping @Sendable () -> String,
            language: WeatherService.Configuration.Language = .englishUS,
            eventLoopGroupProvider: NIOEventLoopGroupProvider = .createNew
        ) {
            self.jwt = jwt
            self.language = language
            self.eventLoopGroupProvider = eventLoopGroupProvider
        }
#else
        public init(
            jwt: @escaping @Sendable () -> String,
            language: WeatherService.Configuration.Language = .englishUS
        ) {
            self.jwt = jwt
            self.language = language
        }
#endif
    }

    private static var configuration: Configuration = Configuration(
        jwt: { preconditionFailure("Configuration must first be set by calling WeatherService.configure(_:).") }
    )

    private let networkClient: NetworkClient
    #if canImport(CoreLocation)
    private let geocoder: Geocoder

    internal init(
        configuration: Configuration,
        networkClient: NetworkClient,
        geocoder: Geocoder
    ) {
        Self.configuration = configuration
        self.networkClient = networkClient
        self.geocoder = geocoder
    }
    #else
    internal init(
        configuration: Configuration,
        networkClient: NetworkClient
    ) {
        Self.configuration = configuration
        self.networkClient = networkClient
    }
    #endif

#if os(Linux)
    public init(configuration: Configuration) {
        Self.configuration = configuration
        self.networkClient = NetworkClient(
            client: HTTPClient(
                eventLoopGroupProvider: configuration.eventLoopGroupProvider.eventLoopGroupProvider
            )
        )
    }

    public func shutdown() async throws {
        try await networkClient.client.shutdown()
    }

#else
    public init(configuration: Configuration) {
        Self.configuration = configuration
        self.networkClient = NetworkClient(
            client: URLSession.shared
        )
        self.geocoder = .live
    }
#endif

    public static func configure(_ configure: (inout Configuration) -> Void) {
        configure(&Self.configuration)

        Self.configuration = configuration
    }

    /// The shared weather service. Use to instantiate one instance of `WeatherService`
    /// for use throughout your application. If finer-grained optimizations are desired, create
    /// separate instances. See the `init` documentation for more details.
    public static let shared: WeatherService = .init(configuration: configuration)

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
    final public func weather(for location: LocationProtocol) async throws -> Weather {
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }
        return try await getWeather(location: location, countryCode: countryCode)
    }
#else
    final public func weather(for location: LocationProtocol, countryCode: String) async throws -> Weather {
        try await getWeather(location: location, countryCode: countryCode)
    }
#endif

    ///
    /// Returns the weather forecast for the requested location. Includes all available weather data sets.
    /// - Parameter location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The aggregate weather.
    ///
    func getWeather(location: LocationProtocol, countryCode: String) async throws -> Weather {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: WeatherQuery<CurrentWeather>.current,
                WeatherQuery<Forecast<MinuteWeather>?>.minute,
                WeatherQuery<Forecast<HourWeather>>.hourly,
                WeatherQuery<Forecast<DayWeather>>.daily,
                WeatherQuery<[WeatherAlert]?>.alerts(countryCode: countryCode),
                WeatherQuery<WeatherAvailability>.availability(countryCode: countryCode),
            jwt: Self.configuration.jwt()
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

    ///
    /// Returns the weather forecast for the requested location. This is a variadic API in which any
    /// combination of data sets can be requested and returned as a tuple.
    /// - Parameter location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested weather data set.
    ///
    /// Example usage:
    /// `let current = try await service.weather(for: newYork, including: .current)`
    ///
    final public func weather<T>(
        for location: LocationProtocol,
        including dataSet: WeatherQuery<T>
    ) async throws -> T {
#if canImport(CoreLocation)
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }

        let _dataSet = dataSet.update(with: countryCode)
#else
        let _dataSet = dataSet
#endif

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: _dataSet,
            jwt: Self.configuration.jwt()
        )

        return try proxy[keyPath: _dataSet.weatherKeyPath]
            .unwrap(or: WeatherError.missingData(_dataSet.queryType.dataSet))
    }

    ///
    /// Returns the weather forecast for the requested location. This is a variadic API in which any
    /// combination of data sets can be requested and returned as a tuple.
    /// - Parameter location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The requested weather data sets as a tuple.
    ///
    /// Example usage:
    /// `let (current, minute) = try await service.weather(for: newYork, including: .current, .minute)`
    ///
    final public func weather<T1, T2>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>
    ) async throws -> (T1, T2) {
#if canImport(CoreLocation)
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }

        let _dataSet1 = dataSet1.update(with: countryCode)
        let _dataSet2 = dataSet2.update(with: countryCode)
#else
        let _dataSet1 = dataSet1
        let _dataSet2 = dataSet2
#endif

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: _dataSet1, _dataSet2,
            jwt: Self.configuration.jwt()
        )

        return try (
            proxy[keyPath: _dataSet1.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet1.queryType.dataSet)),
            proxy[keyPath: _dataSet2.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet2.queryType.dataSet))
        )
    }

    final public func weather<T1, T2, T3>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>
    ) async throws -> (T1, T2, T3) {
#if canImport(CoreLocation)
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }

        let _dataSet1 = dataSet1.update(with: countryCode)
        let _dataSet2 = dataSet2.update(with: countryCode)
        let _dataSet3 = dataSet3.update(with: countryCode)
#else
        let _dataSet1 = dataSet1
        let _dataSet2 = dataSet2
        let _dataSet3 = dataSet3
#endif

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: _dataSet1, _dataSet2, _dataSet3,
            jwt: Self.configuration.jwt()
        )

        return try (
            proxy[keyPath: _dataSet1.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet1.queryType.dataSet)),
            proxy[keyPath: _dataSet2.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet2.queryType.dataSet)),
            proxy[keyPath: _dataSet3.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet3.queryType.dataSet))
        )
    }

    final public func weather<T1, T2, T3, T4>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>
    ) async throws -> (T1, T2, T3, T4) {
#if canImport(CoreLocation)
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }

        let _dataSet1 = dataSet1.update(with: countryCode)
        let _dataSet2 = dataSet2.update(with: countryCode)
        let _dataSet3 = dataSet3.update(with: countryCode)
        let _dataSet4 = dataSet4.update(with: countryCode)
#else
        let _dataSet1 = dataSet1
        let _dataSet2 = dataSet2
        let _dataSet3 = dataSet3
        let _dataSet4 = dataSet4
#endif
        
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: _dataSet1, _dataSet2, _dataSet3, _dataSet4,
            jwt: Self.configuration.jwt()
        )

        return try (
            proxy[keyPath: _dataSet1.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet1.queryType.dataSet)),
            proxy[keyPath: _dataSet2.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet2.queryType.dataSet)),
            proxy[keyPath: _dataSet3.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet3.queryType.dataSet)),
            proxy[keyPath: _dataSet4.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet4.queryType.dataSet))
        )
    }

    final public func weather<T1, T2, T3, T4, T5>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        _ dataSet5: WeatherQuery<T5>
    ) async throws -> (T1, T2, T3, T4, T5) {
#if canImport(CoreLocation)
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }

        let _dataSet1 = dataSet1.update(with: countryCode)
        let _dataSet2 = dataSet2.update(with: countryCode)
        let _dataSet3 = dataSet3.update(with: countryCode)
        let _dataSet4 = dataSet4.update(with: countryCode)
        let _dataSet5 = dataSet5.update(with: countryCode)
#else
        let _dataSet1 = dataSet1
        let _dataSet2 = dataSet2
        let _dataSet3 = dataSet3
        let _dataSet4 = dataSet4
        let _dataSet5 = dataSet5
#endif

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: _dataSet1, _dataSet2, _dataSet3, _dataSet4, _dataSet5,
            jwt: Self.configuration.jwt()
        )

        return try (
            proxy[keyPath: _dataSet1.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet1.queryType.dataSet)),
            proxy[keyPath: _dataSet2.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet2.queryType.dataSet)),
            proxy[keyPath: _dataSet3.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet3.queryType.dataSet)),
            proxy[keyPath: _dataSet4.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet4.queryType.dataSet)),
            proxy[keyPath: _dataSet5.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet5.queryType.dataSet))
        )
    }

    final public func weather<T1, T2, T3, T4, T5, T6>(
        for location: LocationProtocol,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        _ dataSet5: WeatherQuery<T5>,
        _ dataSet6: WeatherQuery<T6>
    ) async throws -> (T1, T2, T3, T4, T5, T6) {
#if canImport(CoreLocation)
        guard let countryCode = try await geocoder.countryCode(location) else { throw WeatherError.countryCode }

        let _dataSet1 = dataSet1.update(with: countryCode)
        let _dataSet2 = dataSet2.update(with: countryCode)
        let _dataSet3 = dataSet3.update(with: countryCode)
        let _dataSet4 = dataSet4.update(with: countryCode)
        let _dataSet5 = dataSet5.update(with: countryCode)
        let _dataSet6 = dataSet6.update(with: countryCode)
#else
        let _dataSet1 = dataSet1
        let _dataSet2 = dataSet2
        let _dataSet3 = dataSet3
        let _dataSet4 = dataSet4
        let _dataSet5 = dataSet5
        let _dataSet6 = dataSet6
#endif

        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: _dataSet1, _dataSet2, _dataSet3, _dataSet4, _dataSet5, _dataSet6,
            jwt: Self.configuration.jwt()
        )

        return try (
            proxy[keyPath: _dataSet1.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet1.queryType.dataSet)),
            proxy[keyPath: _dataSet2.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet2.queryType.dataSet)),
            proxy[keyPath: _dataSet3.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet3.queryType.dataSet)),
            proxy[keyPath: _dataSet4.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet4.queryType.dataSet)),
            proxy[keyPath: _dataSet5.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet5.queryType.dataSet)),
            proxy[keyPath: _dataSet6.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(_dataSet6.queryType.dataSet))
        )
    }
}
