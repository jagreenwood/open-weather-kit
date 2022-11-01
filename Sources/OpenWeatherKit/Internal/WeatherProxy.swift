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

    func combine(with weatherProxy: WeatherProxy) -> WeatherProxy {
        WeatherProxy(
            availability: availability ?? weatherProxy.availability,
            currentWeather: currentWeather ?? weatherProxy.currentWeather,
            dailyForecast: dailyForecast ?? weatherProxy.dailyForecast,
            hourlyForecast: hourlyForecast ?? weatherProxy.hourlyForecast,
            minuteForecast: minuteForecast ?? weatherProxy.minuteForecast,
            weatherAlerts: weatherAlerts ?? weatherProxy.weatherAlerts
        )
    }
}
