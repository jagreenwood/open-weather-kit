//
//  DayWeather.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// A structure that represents the weather conditions for the day.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct DayWeather: Sendable {

    /// The start date of the day weather.
    public var date: Date

    /// A description of the weather condition on this day.
    public var condition: WeatherCondition

    /// The SF Symbol icon that represents the day weather condition. Returns daytime symbol names.
    public var symbolName: String

    /// The daytime high temperature.
    public var highTemperature: Measurement<UnitTemperature>

    /// The time at which the high temperature occurs on this day.
    public var highTemperatureTime: Date?

    /// The overnight low temperature.
    public var lowTemperature: Measurement<UnitTemperature>

    /// The time at which the low temperature occurs on this day.
    public var lowTemperatureTime: Date?

    /// The maximum amount of water vapor in the air for the day.
    ///
    /// Relative humidity measures the amount of water vapor in the air, compared to the maximum amount that the air can hold at the current temperature.
    ///
    /// The range of this property is from `0` to `1`, inclusive.
    public var maximumHumidity: Double

    /// The minimum amount of water vapor in the air for the day.
    ///
    /// Relative humidity measures the amount of water vapor in the air, compared to the maximum amount that the air can hold at the current temperature.
    ///
    /// The range of this property is from `0` to `1`, inclusive.
    public var minimumHumidity: Double

    /// Description of precipitation for this day.
    public var precipitation: Precipitation

    /// The probability of precipitation during the day, from 0 to 1.
    public var precipitationChance: Double

    /// A breakdown of amounts of all forms of precipitation forecasted for the day.
    public var precipitationAmountByType: PrecipitationAmountByType

    /// The solar events for the day.
    public var sun: SunEvents

    /// The lunar events for the day.
    public var moon: MoonEvents

    /// The UV index provides the expected intensity of ultraviolet radiation from the sun.
    public var uvIndex: UVIndex

    /// The maximum distance at which terrain is visible for the day.
    ///
    /// The amount of light, and weather conditions like fog, mist, and smog affect visibility.
    public var maximumVisibility: Double

    /// The minimum distance at which terrain is visible for the day.
    ///
    /// The amount of light, and weather conditions like fog, mist, and smog affect visibility.
    public var minimumVisibility: Double

    /// Contains wind data of speed, bearing (direction), gust.
    public var wind: Wind

    /// The maximum sustained wind speed.
    public var highWindSpeed: Measurement<UnitSpeed>?

    /// The weather forecast from 7AM - 7PM on this day.
    public var daytimeForecast: DayPartForecast

    /// The weather forecast for 7PM on this day until 7AM the following day.
    public var overnightForecast: DayPartForecast

    /// The forecast from now until midnight local time.
    ///
    /// The value is only available for the current day.
    public var restOfDayForecast: DayPartForecast?

    internal init(
        date: Date,
        condition: WeatherCondition,
        symbolName: String,
        highTemperature: Measurement<UnitTemperature>,
        highTemperatureTime: Date?,
        lowTemperature: Measurement<UnitTemperature>,
        lowTemperatureTime: Date?,
        maximumHumidity: Double,
        minimumHumidity: Double,
        precipitation: Precipitation,
        precipitationChance: Double,
        precipitationAmountByType: PrecipitationAmountByType,
        sun: SunEvents,
        moon: MoonEvents,
        uvIndex: UVIndex,
        maximumVisibility: Double,
        minimumVisibility: Double,
        wind: Wind,
        highWindSpeed: Measurement<UnitSpeed>?,
        daytimeForecast: DayPartForecast,
        overnightForecast: DayPartForecast,
        restOfDayForecast: DayPartForecast?
    ) {
        self.date = date
        self.condition = condition
        self.symbolName = symbolName
        self.highTemperature = highTemperature
        self.highTemperatureTime = highTemperatureTime
        self.lowTemperature = lowTemperature
        self.lowTemperatureTime = lowTemperatureTime
        self.maximumHumidity = maximumHumidity
        self.minimumHumidity = minimumHumidity
        self.precipitation = precipitation
        self.precipitationChance = precipitationChance
        self.precipitationAmountByType = precipitationAmountByType
        self.sun = sun
        self.moon = moon
        self.uvIndex = uvIndex
        self.maximumVisibility = maximumVisibility
        self.minimumVisibility = minimumVisibility
        self.wind = wind
        self.highWindSpeed = highWindSpeed
        self.daytimeForecast = daytimeForecast
        self.overnightForecast = overnightForecast
        self.restOfDayForecast = restOfDayForecast
    }
}

extension DayWeather: Codable {}
extension DayWeather: Equatable {}
