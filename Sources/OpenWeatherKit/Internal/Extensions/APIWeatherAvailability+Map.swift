//
//  APIWeatherAvailability+Map.swift
//  
//
//  Created by Jeremy Greenwood on 10/27/22.
//

@preconcurrency import Foundation

extension Array where Element == APIWeatherAvailability {
    var weatherAvailability: WeatherAvailability {
        WeatherAvailability(
            minuteAvailability: contains(.forecastNextHour) ? .available : .temporarilyUnavailable,
            alertAvailability: contains(.weatherAlerts) ? .available :.temporarilyUnavailable
        )
    }

    var weatherProxy: WeatherProxy {
        WeatherProxy(
            availability: weatherAvailability,
            currentWeather: nil,
            dailyForecast: nil,
            hourlyForecast: nil,
            minuteForecast: nil,
            weatherAlerts: nil
        )
    }
}
