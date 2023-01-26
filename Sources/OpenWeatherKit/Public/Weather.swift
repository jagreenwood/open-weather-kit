//
//  Weather.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// A model representing the aggregate weather data the caller requests.
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct Weather: Sendable {

    /// The current weather forecast.
    public var currentWeather: CurrentWeather

    /// The minute-by-minute forecast. Optional due to unsupported regions and availability of data.
    public var minuteForecast: Forecast<MinuteWeather>?

    /// The hourly forecast.
    public var hourlyForecast: Forecast<HourWeather>

    /// The daily forecast.
    public var dailyForecast: Forecast<DayWeather>

    /// The severe weather alerts.
    public var weatherAlerts: [WeatherAlert]?

    /// The flags containing information about data availability and attribution.
    public var availability: WeatherAvailability
}

extension Weather: Codable {}
