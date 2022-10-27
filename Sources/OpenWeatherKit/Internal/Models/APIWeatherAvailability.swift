//
//  APIWeatherAvailability.swift
//  
//
//  Created by Jeremy Greenwood on 10/27/22.
//

import Foundation

enum APIWeatherAvailability: String, Codable, Equatable {
    case currentWeather
    case forecastDaily
    case forecastHourly
    case forecastNextHour
    case weatherAlerts
}
