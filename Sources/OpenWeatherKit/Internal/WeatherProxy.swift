//
//  WeatherProxy.swift
//  
//
//  Created by Jeremy Greenwood on 10/23/22.
//

import Foundation

struct WeatherProxy {
    init(
        availability: WeatherAvailability?,
        currentWeather: CurrentWeather?,
        dailyForecast: Forecast<DayWeather>?,
        hourlyForecast: Forecast<HourWeather>?,
        minuteForecast: Forecast<MinuteWeather>?,
        weatherAlerts: [WeatherAlert]?
    ) {
        self.availability = availability
        self.currentWeather = currentWeather
        self.dailyForecast = dailyForecast
        self.hourlyForecast = hourlyForecast
        self.minuteForecast = minuteForecast
        self.weatherAlerts = weatherAlerts
    }

    var availability: WeatherAvailability?
    var currentWeather: CurrentWeather?
    var dailyForecast: Forecast<DayWeather>?
    var hourlyForecast: Forecast<HourWeather>?
    var minuteForecast: Forecast<MinuteWeather>?
    var weatherAlerts: [WeatherAlert]?
}

extension APIWeather {
    var weatherProxy: WeatherProxy {
        WeatherProxy(
            availability: nil,
            currentWeather: currentWeather?.currentWeather,
            dailyForecast: forecastDaily?.dailyForecast,
            hourlyForecast: forecastHourly?.hourForecast,
            minuteForecast: forecastNextHour?.minuteForecast,
            weatherAlerts: weatherAlerts?.map(\.weatherAlert)
        )
    }
}

extension APIMetadata {
    var weatherMetadata: WeatherMetadata {
        WeatherMetadata(
            date: readTime,
            expirationDate: expireTime,
            location: Location(latitude: latitude, longitude: longitude)
        )
    }
}
