//
//  WeatherService.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

final public class WeatherService : @unchecked Sendable {
    public struct Configuration {
        public enum Language {
            case englishUS

            var languageCode: String {
                switch self {
                case .englishUS: return "en_US"
                }
            }
        }

        public var jwt: () -> String
        public var language: Language

        public init(
            jwt: @escaping () -> String,
            language: WeatherService.Configuration.Language = .englishUS
        ) {
            self.jwt = jwt
            self.language = language
        }
    }

    private let configuration: Configuration

    public init(configuration: Configuration) {
        self.configuration = configuration
    }

    public static func configure(_ configure: (inout Configuration) -> Void) {
        var configuration = Configuration(jwt: { preconditionFailure("The JWT must be configured.") })
        configure(&configuration)

        Self.shared = .init(configuration: configuration)
    }

    /// The shared weather service. Use to instantiate one instance of `WeatherService`
    /// for use throughout your application. If finer-grained optimizations are desired, create
    /// separate instances. See the `init` documentation for more details.
    public static var shared: WeatherService = {
        WeatherService(configuration: Configuration {
            preconditionFailure("Configuration must first be set by calling WeatherService.configure(_:).")
        })
    }()

    /// The required attribution which includes a legal attribution page and Apple Weather mark.
    /// async throws
    final public var attribution: WeatherAttribution {
        fatalError("not implemented")
    }

    ///
    /// Returns the weather forecast for the requested location. Includes all available weather data sets.
    /// - Parameter location: The requested location.
    /// - Throws: Weather data error `WeatherError`
    /// - Returns: The aggregate weather.
    ///
    final public func weather(for location: Location, countryCode: String) async throws -> Weather {
        let proxy = try await NetworkClient.fetchWeather(
            location: location,
            language: configuration.language,
            queries: WeatherQuery<CurrentWeather>.current,
                WeatherQuery<Forecast<MinuteWeather>?>.minute,
                WeatherQuery<Forecast<HourWeather>>.hourly,
                WeatherQuery<Forecast<DayWeather>>.daily,
                WeatherQuery<[WeatherAlert]?>.alerts(countryCode: countryCode),
                WeatherQuery<WeatherAvailability>.availability,
            jwt: configuration.jwt()
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
        let proxy = try await NetworkClient.fetchWeather(
            location: location,
            language: configuration.language,
            queries: dataSet,
            jwt: configuration.jwt()
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
        let proxy = try await NetworkClient.fetchWeather(
            location: location,
            language: configuration.language,
            queries: dataSet1, dataSet2,
            jwt: configuration.jwt()
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
        let proxy = try await NetworkClient.fetchWeather(
            location: location,
            language: configuration.language,
            queries: dataSet1, dataSet2, dataSet3,
            jwt: configuration.jwt()
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
        let proxy = try await NetworkClient.fetchWeather(
            location: location,
            language: configuration.language,
            queries: dataSet1, dataSet2, dataSet3, dataSet4,
            jwt: configuration.jwt()
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
        let proxy = try await NetworkClient.fetchWeather(
            location: location,
            language: configuration.language,
            queries: dataSet1, dataSet2, dataSet3, dataSet4, dataSet5,
            jwt: configuration.jwt()
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
        let proxy = try await NetworkClient.fetchWeather(
            location: location,
            language: configuration.language,
            queries: dataSet1, dataSet2, dataSet3, dataSet4, dataSet5, dataSet6,
            jwt: configuration.jwt()
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
