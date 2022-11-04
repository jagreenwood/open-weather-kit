//
//  DayWeather.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct DayWeather: Sendable {

    /// The start date of the day weather.
    public var date: Date

    /// A description of the weather condition on this day.
    public var condition: WeatherCondition

    /// The SF Symbol icon that represents the day weather condition. Returns daytime symbol names.
    public var symbolName: String

    /// The daytime high temperature.
    public var highTemperature: Measurement<UnitTemperature>

    /// The overnight low temperature.
    public var lowTemperature: Measurement<UnitTemperature>

    /// Description of precipitation for this day.
    public var precipitation: Precipitation

    /// The probability of precipitation during the day, from 0 to 1.
    public var precipitationChance: Double

    /// The amount of rainfall for the day.
    public var rainfallAmount: Measurement<UnitLength>

    /// The amount of snowfall for the day.
    public var snowfallAmount: Measurement<UnitLength>

    /// The solar events for the day.
    public var sun: SunEvents

    /// The lunar events for the day.
    public var moon: MoonEvents

    /// The UV index provides the expected intensity of ultraviolet radiation from the sun.
    public var uvIndex: UVIndex

    /// Contains wind data of speed, bearing (direction), gust.
    public var wind: Wind
}

extension DayWeather: Codable {}
extension DayWeather: Equatable {}
