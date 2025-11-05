//
//  DayPartForecast.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 2/20/25.
//

import Foundation

///
/// A structure that represents the weather forecast for part of the day.
///
public struct DayPartForecast: Sendable {

    /// The percentage of the sky covered with clouds.
    ///
    /// The value is from `0` (no cloud cover)  to `1` (complete cloud cover).
    ///
    public var cloudCover: Double

    /// The fraction of sky obscured by low altitude, medium altitude, and high altitude clouds.
    public var cloudCoverByAltitude: CloudCoverByAltitude

    /// A description of the weather condition
    public var condition: WeatherCondition

    /// The high temperature for the day part.
    public var highTemperature: Measurement<UnitTemperature>

    /// The overnight low temperature for the day part.
    public var lowTemperature: Measurement<UnitTemperature>

    /// The description of precipitation for the day part.
    public var precipitation: Precipitation

    /// A breakdown of all precipitation forecasted for the day.
    public var precipitationAmountByType: PrecipitationAmountByType

    /// The probability of precipitation for the day part.
    ///
    /// The value is from `0` (no chance of precipitation) to `1` (100% chance of precipitation).
    public var precipitationChance: Double

    /// The maximum humidity for the day part.
    /// Relative humidity measures the amount of water vapor in the air, compared to the maximum amount that the air can hold at the current temperature.
    ///
    /// The range of this property is from `0` to `1`, inclusive.
    public var maximumHumidity: Double

    /// The minimum humidity for the day part.
    /// Relative humidity measures the amount of water vapor in the air, compared to the maximum amount that the air can hold at the current temperature.
    ///
    /// The range of this property is from `0` to `1`, inclusive.
    public var minimumHumidity: Double

    /// The maximum visibility for the day part.
    public var maximumVisibility: Measurement<UnitLength>

    /// The minimum visibility for the day part.
    public var minimumVisibility: Measurement<UnitLength>

    /// Wind data describing the wind speed, direction, and gust.
    public var wind: Wind

    /// The maximum sustained wind speed for the day part.
    public var highWindSpeed: Measurement<UnitSpeed>
}

extension DayPartForecast: Codable {}
extension DayPartForecast: Equatable {}
