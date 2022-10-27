//
//  WeatherQuery.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct WeatherQuery<T> {
    let endDate: Date?
    let query: String
    let startDate: Date?
    let weatherKeyPath: KeyPath<WeatherProxy, T?>

    init(endDate: Date? = nil, query: String, startDate: Date? = nil, weatherKeyPath: KeyPath<WeatherProxy, T?>) {
        self.endDate = endDate
        self.query = query
        self.startDate = startDate
        self.weatherKeyPath = weatherKeyPath
    }

    /// The current weather query.
    public static var current: WeatherQuery<CurrentWeather> {
        WeatherQuery<CurrentWeather>(
            query: APIWeather.CodingKeys.currentWeather.rawValue,
            weatherKeyPath: \.currentWeather
        )
    }

    /// The minute forecast query.
    public static var minute: WeatherQuery<Forecast<MinuteWeather>?> {
        WeatherQuery<Forecast<MinuteWeather>?>(
            query: APIWeather.CodingKeys.forecastNextHour.rawValue,
            weatherKeyPath: \.minuteForecast?
        )
    }

    /// The hourly forecast query.
    public static var hourly: WeatherQuery<Forecast<HourWeather>> {
        WeatherQuery<Forecast<HourWeather>>(
            query: APIWeather.CodingKeys.forecastHourly.rawValue,
            weatherKeyPath: \.hourlyForecast
        )
    }

    /// The daily forecast query.
    public static var daily: WeatherQuery<Forecast<DayWeather>> {
        WeatherQuery<Forecast<DayWeather>>(
            query: APIWeather.CodingKeys.forecastDaily.rawValue,
            weatherKeyPath: \.dailyForecast
        )
    }

    /// The weather alerts query.
    public static var alerts: WeatherQuery<[WeatherAlert]?> {
        WeatherQuery<[WeatherAlert]?>(
            query: APIWeather.CodingKeys.weatherAlerts.rawValue,
            weatherKeyPath: \.weatherAlerts?
        )
    }

    /// The availability query.
    public static var availability: WeatherQuery<WeatherAvailability> {
        WeatherQuery<WeatherAvailability>(
            query: "availability",
            weatherKeyPath: \.availability)
    }
}

public extension WeatherQuery<Forecast<DayWeather>> {
    /// The daily forecast query that takes a start date and end date for the request.
    static func daily(
        startDate: Date,
        endDate: Date
    ) -> WeatherQuery<T> {
        WeatherQuery<Forecast<DayWeather>>(
            endDate: endDate,
            query: APIWeather.CodingKeys.forecastDaily.rawValue,
            startDate: startDate,
            weatherKeyPath: \.dailyForecast
        )
    }
}

public extension WeatherQuery<Forecast<HourWeather>> {
    static func hourly(
        startDate: Date,
        endDate: Date
    ) -> WeatherQuery<T> {
        WeatherQuery<Forecast<HourWeather>>(
            endDate: endDate,
            query: APIWeather.CodingKeys.forecastHourly.rawValue,
            startDate: startDate,
            weatherKeyPath: \.hourlyForecast
        )
    }
}
