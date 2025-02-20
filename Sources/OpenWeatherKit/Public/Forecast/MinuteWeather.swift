//
//  MinuteWeather.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// A structure that represents the next hour minute forecasts.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct MinuteWeather: Sendable {

    /// The start date of the minute weather.
    public var date: Date

    /// Description of precipitation for this minute.
    public var precipitation: Precipitation

    /// Probability of precipitation in this minute from 0.0 to 1.0.
    public var precipitationChance: Double

    /// Forecasted precipitation intensity in km/hr.
    public var precipitationIntensity: Measurement<UnitSpeed>
}

extension MinuteWeather: Codable {}
extension MinuteWeather: Equatable {}
