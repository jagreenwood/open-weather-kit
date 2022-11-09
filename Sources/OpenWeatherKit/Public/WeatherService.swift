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

    ///
    /// Returns the weather forecast for the requested location. Includes all available weather data sets.
    /// - Parameter location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The aggregate weather.
    ///
    final public func weather(for location: Location, countryCode: String) async throws -> Weather {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: WeatherQuery<CurrentWeather>.current,
                WeatherQuery<Forecast<MinuteWeather>?>.minute,
                WeatherQuery<Forecast<HourWeather>>.hourly,
                WeatherQuery<Forecast<DayWeather>>.daily,
                WeatherQuery<[WeatherAlert]?>.alerts(countryCode: countryCode),
                WeatherQuery<WeatherAvailability>.availability,
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
        for location: Location,
        including dataSet: WeatherQuery<T>
    ) async throws -> T {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: dataSet,
            jwt: Self.configuration.jwt()
        )

        return try proxy[keyPath: dataSet.weatherKeyPath]
            .unwrap(or: WeatherError.missingData(dataSet.queryType.dataSet))
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
        for location: Location,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>
    ) async throws -> (T1, T2) {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: dataSet1, dataSet2,
            jwt: Self.configuration.jwt()
        )

        return try (
            proxy[keyPath: dataSet1.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet1.queryType.dataSet)),
            proxy[keyPath: dataSet2.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet2.queryType.dataSet))
        )
    }

    final public func weather<T1, T2, T3>(
        for location: Location,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>
    ) async throws -> (T1, T2, T3) {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: dataSet1, dataSet2, dataSet3,
            jwt: Self.configuration.jwt()
        )

        return try (
            proxy[keyPath: dataSet1.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet1.queryType.dataSet)),
            proxy[keyPath: dataSet2.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet2.queryType.dataSet)),
            proxy[keyPath: dataSet3.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet3.queryType.dataSet))
        )
    }

    final public func weather<T1, T2, T3, T4>(
        for location: Location,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>
    ) async throws -> (T1, T2, T3, T4) {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: dataSet1, dataSet2, dataSet3, dataSet4,
            jwt: Self.configuration.jwt()
        )

        return try (
            proxy[keyPath: dataSet1.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet1.queryType.dataSet)),
            proxy[keyPath: dataSet2.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet2.queryType.dataSet)),
            proxy[keyPath: dataSet3.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet3.queryType.dataSet)),
            proxy[keyPath: dataSet4.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet4.queryType.dataSet))
        )
    }

    final public func weather<T1, T2, T3, T4, T5>(
        for location: Location,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        _ dataSet5: WeatherQuery<T5>
    ) async throws -> (T1, T2, T3, T4, T5) {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: dataSet1, dataSet2, dataSet3, dataSet4, dataSet5,
            jwt: Self.configuration.jwt()
        )

        return try (
            proxy[keyPath: dataSet1.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet1.queryType.dataSet)),
            proxy[keyPath: dataSet2.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet2.queryType.dataSet)),
            proxy[keyPath: dataSet3.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet3.queryType.dataSet)),
            proxy[keyPath: dataSet4.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet4.queryType.dataSet)),
            proxy[keyPath: dataSet5.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet5.queryType.dataSet))
        )
    }

    final public func weather<T1, T2, T3, T4, T5, T6>(
        for location: Location,
        including dataSet1: WeatherQuery<T1>,
        _ dataSet2: WeatherQuery<T2>,
        _ dataSet3: WeatherQuery<T3>,
        _ dataSet4: WeatherQuery<T4>,
        _ dataSet5: WeatherQuery<T5>,
        _ dataSet6: WeatherQuery<T6>
    ) async throws -> (T1, T2, T3, T4, T5, T6) {
        let proxy = try await networkClient.fetchWeather(
            location: location,
            language: Self.configuration.language,
            queries: dataSet1, dataSet2, dataSet3, dataSet4, dataSet5, dataSet6,
            jwt: Self.configuration.jwt()
        )

        return try (
            proxy[keyPath: dataSet1.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet1.queryType.dataSet)),
            proxy[keyPath: dataSet2.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet2.queryType.dataSet)),
            proxy[keyPath: dataSet3.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet3.queryType.dataSet)),
            proxy[keyPath: dataSet4.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet4.queryType.dataSet)),
            proxy[keyPath: dataSet5.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet5.queryType.dataSet)),
            proxy[keyPath: dataSet6.weatherKeyPath]
                .unwrap(or: WeatherError.missingData(dataSet6.queryType.dataSet))
        )
    }
}
