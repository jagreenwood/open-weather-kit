//
//  HourWeather.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct HourWeather: Sendable {

    /// The start date of the hour weather.
    public var date: Date

    /// Fraction of cloud cover, from 0 to 1. Cloud cover describes the fraction of
    /// sky obscured by clouds when observed from a given location.
    public var cloudCover: Double

    /// A description of the weather condition for this hour.
    public var condition: WeatherCondition

    /// The SF Symbol icon that represents the hour weather condition and whether it's daylight on the hour.
    public var symbolName: String

    /// The dew point, which describes the amount of moisture in the air, is the temperature at which air
    /// is saturated with water vapor.
    public var dewPoint: Measurement<UnitTemperature>

    /// The humidity for the hour, from 0 to 1, inclusive. Relative humidity measures the amount of
    /// water vapor in the air compared to the maximum amount that the air could normally
    /// hold at the current temperature.
    public var humidity: Double

    /// The presence or absence of daylight at the requested location and hour.
    public var isDaylight: Bool

    /// Description of precipitation for this hour.
    public var precipitation: Precipitation

    /// The probability of precipitation during the hour, from 0 to 1.
    public var precipitationChance: Double

    /// The amount of precipitation for the hour. This value refers to the liquid equivalent of all
    /// precipitation amounts.
    public var precipitationAmount: Measurement<UnitLength>

    /// The sea level pressure, which describes the atmospheric pressure at sea level at a given location.
    /// It is a reduced pressure calculated by using observed conditions to remove the effects of elevation
    /// from pressure readings.
    public var pressure: Measurement<UnitPressure>

    /// The pressure trend, or barometric tendency, is the kind and amount of atmospheric pressure
    /// change over time.
    public var pressureTrend: PressureTrend

    /// The temperature during the hour.
    public var temperature: Measurement<UnitTemperature>

    /// The apparent or "feels like" temperature during the hour.
    public var apparentTemperature: Measurement<UnitTemperature>

    /// The UV index provides the expected intensity of ultraviolet radiation from the sun.
    public var uvIndex: UVIndex

    /// The visibility for the hour. Visibility is the distance at which an object can be clearly seen
    /// and is affected by the amount of light and weather conditions like fog, mist, and smog.
    public var visibility: Measurement<UnitLength>

    /// Contains wind data describing the wind speed, direction, and gust.
    public var wind: Wind
}

extension HourWeather: Codable {}
extension HourWeather: Equatable {}
