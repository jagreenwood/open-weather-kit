//
//  WeatherAvailability.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

@preconcurrency import Foundation

public struct WeatherAvailability: Sendable {

    /// The minute forecast availability.
    public var minuteAvailability: WeatherAvailability.AvailabilityKind

    /// The weather alerts availability.
    public var alertAvailability: WeatherAvailability.AvailabilityKind

    /// The availability kind.
    public enum AvailabilityKind : String, Codable, Sendable {

        /// The data is available.
        case available

        /// The data is supported for the location but is temporarily unavailable.
        case temporarilyUnavailable

        /// The data isn't supported for the location.
        case unsupported

        case unknown
    }
}

extension WeatherAvailability: Codable {}
