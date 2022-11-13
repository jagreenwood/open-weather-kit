//
//  APIWeather+Map.swift
//  
//
//  Created by Jeremy Greenwood on 10/31/22.
//

import Foundation

extension APIWeather {
    var weatherProxy: WeatherProxy {
        WeatherProxy(
            availability: nil,
            currentWeather: currentWeather?.currentWeather,
            dailyForecast: forecastDaily?.dailyForecast,
            hourlyForecast: forecastHourly?.hourForecast,
            minuteForecast: forecastNextHour?.minuteForecast,
            weatherAlerts: weatherAlerts?.weatherAlerts
        )
    }
}
