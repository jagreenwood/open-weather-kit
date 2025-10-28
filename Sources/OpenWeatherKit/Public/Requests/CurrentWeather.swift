//
//  CurrentWeather.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// A structure that describes the current conditions observed at a location.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct CurrentWeather: Sendable {
    public init(
        date: Date,
        cloudCover: Double,
        condition: WeatherCondition,
        symbolName: String,
        dewPoint: Measurement<UnitTemperature>,
        humidity: Double,
        percipationIntensity: Measurement<UnitSpeed>,
        pressure: Measurement<UnitPressure>,
        pressureTrend: PressureTrend,
        isDaylight: Bool,
        temperature: Measurement<UnitTemperature>,
        apparentTemperature: Measurement<UnitTemperature>,
        uvIndex: UVIndex,
        visibility: Measurement<UnitLength>,
        wind: Wind,
        metadata: WeatherMetadata
    ) {
        self.date = date
        self.cloudCover = cloudCover
        self.condition = condition
        self.symbolName = symbolName
        self.dewPoint = dewPoint
        self.humidity = humidity
        self.percipationIntensity = percipationIntensity
        self.pressure = pressure
        self.pressureTrend = pressureTrend
        self.isDaylight = isDaylight
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.uvIndex = uvIndex
        self.visibility = visibility
        self.wind = wind
        self.metadata = metadata
    }

    /// The date of the current weather.
    public var date: Date

    /// Fraction of cloud cover, from 0 to 1. Cloud cover describes the fraction of
    /// sky obscured by clouds when observed from a given location.
    public var cloudCover: Double

    /// A description of the current weather condition.
    public var condition: WeatherCondition

    /// The SF Symbol icon that represents the current weather condition and whether it's
    /// daylight at the current date.
    public var symbolName: String

    /// The amount of moisture in the air.
    ///
    /// Dew point is the temperature at which air is saturated with water vapor.
    public var dewPoint: Measurement<UnitTemperature>

    /// The amount of water vapor in the air.
    ///
    /// Relative humidity measures the amount of water vapor in the air compared to the maximum amount that the air could normally hold at the current temperature.
    ///
    /// The range of this property is from 0 to 1, inclusive.
    public var humidity: Double
    
    /// The precipitation intensity, in millimeters per hour.
    public var percipationIntensity: Measurement<UnitSpeed>

    /// The atmospheric pressure at sea level at a given location.
    ///
    /// This is a reduced pressure calculated by using observed conditions to remove the effects of elevation
    /// from pressure readings.
    public var pressure: Measurement<UnitPressure>

    /// The pressure trend, or barometric tendency, is the kind and amount of atmospheric pressure
    /// change over time.
    public var pressureTrend: PressureTrend

    /// The presence or absence of daylight at the requested location and current time.
    public var isDaylight: Bool

    /// The current temperature.
    public var temperature: Measurement<UnitTemperature>

    /// The apparent, or "feels like" temperature.
    public var apparentTemperature: Measurement<UnitTemperature>

    /// The expected intensity of ultraviolet radiation from the sun.
    public var uvIndex: UVIndex

    /// The distance at which an object can be clearly seen.
    ///
    /// The amount of light, and weather conditions like fog, mist, and smog affect visibility.
    public var visibility: Measurement<UnitLength>

    /// The wind speed, direction, and gust.
    public var wind: Wind

    /// The current weather metadata.
    public var metadata: WeatherMetadata
}

extension CurrentWeather: Codable {}
