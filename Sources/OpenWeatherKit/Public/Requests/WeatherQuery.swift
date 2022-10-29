//
//  WeatherQuery.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct WeatherQuery<T> {
    let countryCode: String?
    let dataSet: String
    let endDate: Date?
    let startDate: Date?
    let weatherKeyPath: KeyPath<WeatherProxy, T?>

    init(
        countryCode: String? = nil,
        endDate: Date? = nil,
        dataSet: String,
        startDate: Date? = nil,
        weatherKeyPath: KeyPath<WeatherProxy, T?>
    ) {
        self.countryCode = countryCode
        self.endDate = endDate
        self.dataSet = dataSet
        self.startDate = startDate
        self.weatherKeyPath = weatherKeyPath
    }

    /// The current weather query.
    public static var current: WeatherQuery<CurrentWeather> {
        WeatherQuery<CurrentWeather>(
            dataSet: APIWeather.CodingKeys.currentWeather.rawValue,
            weatherKeyPath: \.currentWeather
        )
    }

    /// The minute forecast query.
    public static var minute: WeatherQuery<Forecast<MinuteWeather>?> {
        WeatherQuery<Forecast<MinuteWeather>?>(
            dataSet: APIWeather.CodingKeys.forecastNextHour.rawValue,
            weatherKeyPath: \.minuteForecast?
        )
    }

    /// The hourly forecast query.
    public static var hourly: WeatherQuery<Forecast<HourWeather>> {
        WeatherQuery<Forecast<HourWeather>>(
            dataSet: APIWeather.CodingKeys.forecastHourly.rawValue,
            weatherKeyPath: \.hourlyForecast
        )
    }

    /// The daily forecast query.
    public static var daily: WeatherQuery<Forecast<DayWeather>> {
        WeatherQuery<Forecast<DayWeather>>(
            dataSet: APIWeather.CodingKeys.forecastDaily.rawValue,
            weatherKeyPath: \.dailyForecast
        )
    }

    /// The availability query.
    public static var availability: WeatherQuery<WeatherAvailability> {
        WeatherQuery<WeatherAvailability>(
            dataSet: "availability",
            weatherKeyPath: \.availability)
    }
}

public extension WeatherQuery where T == Forecast<DayWeather> {
    /// The daily forecast query that takes a start date and end date for the request.
    static func daily(
        startDate: Date,
        endDate: Date
    ) -> WeatherQuery<T> {
        WeatherQuery<Forecast<DayWeather>>(
            endDate: endDate,
            dataSet: APIWeather.CodingKeys.forecastDaily.rawValue,
            startDate: startDate,
            weatherKeyPath: \.dailyForecast
        )
    }
}

public extension WeatherQuery where T == Forecast<HourWeather> {
    static func hourly(
        startDate: Date,
        endDate: Date
    ) -> WeatherQuery<T> {
        WeatherQuery<Forecast<HourWeather>>(
            endDate: endDate,
            dataSet: APIWeather.CodingKeys.forecastHourly.rawValue,
            startDate: startDate,
            weatherKeyPath: \.hourlyForecast
        )
    }
}

public extension WeatherQuery where T == [WeatherAlert]? {
    /// The weather alerts query.
    static func alerts(countryCode: String) -> WeatherQuery<T> {
        WeatherQuery<[WeatherAlert]?>(
            countryCode: countryCode,
            dataSet: APIWeather.CodingKeys.weatherAlerts.rawValue,
            weatherKeyPath: \.weatherAlerts?
        )
    }
}
