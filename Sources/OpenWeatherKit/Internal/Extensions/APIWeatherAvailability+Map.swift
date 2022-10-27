//
//  APIWeatherAvailability+Map.swift
//  
//
//  Created by Jeremy Greenwood on 10/27/22.
//

import Foundation

extension Array where Element == APIWeatherAvailability {
    var weatherAvailability: WeatherAvailability {
        WeatherAvailability(
            minuteAvailability: contains(.forecastNextHour) ? .available : .unsupported,
            alertAvailability: contains(.weatherAlerts) ? .available :.unsupported
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
