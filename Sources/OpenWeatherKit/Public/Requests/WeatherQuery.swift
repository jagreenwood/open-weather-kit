//
//  WeatherQuery.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct WeatherQuery<T> {

    /// The current weather query.
    public static var current: WeatherQuery<CurrentWeather> {
        fatalError("not implemented")
    }

    /// The minute forecast query.
    public static var minute: WeatherQuery<Forecast<MinuteWeather>?> {
        fatalError("not implemented")
    }

    /// The hourly forecast query.
    public static var hourly: WeatherQuery<Forecast<HourWeather>> {
        fatalError("not implemented")
    }

    /// The daily forecast query.
    public static var daily: WeatherQuery<Forecast<DayWeather>> {
        fatalError("not implemented")
    }

    /// The weather alerts query.
    public static var alerts: WeatherQuery<[WeatherAlert]?> {
        fatalError("not implemented")
    }

    /// The availability query.
    public static var availability: WeatherQuery<WeatherAvailability> {
        fatalError("not implemented")
    }
}
