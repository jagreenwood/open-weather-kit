//
//  WeatherService.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

final public class WeatherService : @unchecked Sendable {

    /// The shared weather service. Use to instantiate one instance of `WeatherService`
    /// for use throughout your application. If finer-grained optimizations are desired, create
    /// separate instances. See the `init` documentation for more details.
    public static let shared: WeatherService = {
        fatalError("not implemented")
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
    final public func weather(for location: Location) async throws -> Weather {
        fatalError("not implemented")
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
    final public func weather<T>(for location: Location, including dataSet: WeatherQuery<T>) async throws -> T {
        fatalError("not implemented")
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
    final public func weather<T1, T2>(for location: Location, including dataSet1: WeatherQuery<T1>, _ dataSet2: WeatherQuery<T2>) async throws -> (T1, T2) {
        fatalError("not implemented")
    }

    final public func weather<T1, T2, T3>(for location: Location, including dataSet1: WeatherQuery<T1>, _ dataSet2: WeatherQuery<T2>, _ dataSet3: WeatherQuery<T3>) async throws -> (T1, T2, T3) {
        fatalError("not implemented")
    }

    final public func weather<T1, T2, T3, T4>(for location: Location, including dataSet1: WeatherQuery<T1>, _ dataSet2: WeatherQuery<T2>, _ dataSet3: WeatherQuery<T3>, _ dataSet4: WeatherQuery<T4>) async throws -> (T1, T2, T3, T4) {
        fatalError("not implemented")
    }

    final public func weather<T1, T2, T3, T4, T5>(for location: Location, including dataSet1: WeatherQuery<T1>, _ dataSet2: WeatherQuery<T2>, _ dataSet3: WeatherQuery<T3>, _ dataSet4: WeatherQuery<T4>, _ dataSet5: WeatherQuery<T5>) async throws -> (T1, T2, T3, T4, T5) {
        fatalError("not implemented")
    }

    final public func weather<T1, T2, T3, T4, T5, T6>(for location: Location, including dataSet1: WeatherQuery<T1>, _ dataSet2: WeatherQuery<T2>, _ dataSet3: WeatherQuery<T3>, _ dataSet4: WeatherQuery<T4>, _ dataSet5: WeatherQuery<T5>, _ dataSet6: WeatherQuery<T6>) async throws -> (T1, T2, T3, T4, T5, T6) {
        fatalError("not implemented")
    }
}
