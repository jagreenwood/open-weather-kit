//
//  Route.swift
//  
//
//  Created by Jeremy Greenwood on 10/28/22.
//

import Foundation

enum Route {
    case availability(Location)
    case weather(WeatherService.Configuration.Language, Location)

    var url: URL {
        let base = "https://weatherkit.apple.com"

        switch self {
        case let .availability(location): return URL(string: "\(base)/api/v1/availability/\(location.latitude)/\(location.longitude)")!
        case let .weather(language, location): return URL(string: "\(base)/api/v1/weather/\(language.languageCode)/\(location.latitude)/\(location.longitude)")!
        }
    }
}
