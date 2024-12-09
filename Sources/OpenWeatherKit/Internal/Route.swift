//
//  Route.swift
//  
//
//  Created by Jeremy Greenwood on 10/28/22.
//

import Foundation

enum Route {
    case availability(LocationProtocol)
    case weather(WeatherService.Configuration.Language, LocationProtocol)

    var url: URL {
        let urlString: String = {
            let base = "https://weatherkit.apple.com"

            switch self {
            case let .availability(location): return "\(base)/api/v1/availability/\(location.latitude)/\(location.longitude)"
            case let .weather(language, location): return "\(base)/api/v1/weather/\(language.rawValue)/\(location.latitude)/\(location.longitude)"
            }
        }()

        return URL(string: urlString)!
    }
}
