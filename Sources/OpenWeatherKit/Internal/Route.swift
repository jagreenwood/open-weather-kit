//
//  Route.swift
//
//
//  Created by Jeremy Greenwood on 10/28/22.
//

import Foundation

enum StatisticsGranularity: String {
    case hourly
    case daily
    case monthly
}

enum Route {
    case availability(LocationProtocol)
    case weather(WeatherService.Configuration.Language, LocationProtocol)
    case dailySummary(LocationProtocol)
    case statistics(StatisticsGranularity, LocationProtocol)

    var url: URL {
        let urlString: String = {
            let base = "https://weatherkit.apple.com"

            switch self {
            case let .availability(location):
                return "\(base)/api/v2/availability/\(location.latitude)/\(location.longitude)"
            case let .weather(language, location):
                return "\(base)/api/v2/weather/\(language.rawValue)/\(location.latitude)/\(location.longitude)"
            case let .dailySummary(location):
                return "\(base)/api/v2/summary/daily/\(location.latitude)/\(location.longitude)"
            case let .statistics(granularity, location):
                return "\(base)/api/v2/statistics/\(granularity.rawValue)/\(location.latitude)/\(location.longitude)"
            }
        }()

        return URL(string: urlString)!
    }
}
