//
//  MockClient.swift
//  
//
//  Created by Jeremy Greenwood on 11/9/22.
//

import Foundation
@testable import OpenWeatherKit

struct MockClient: Client {
    enum Include {
        case availability
        case current
        case daily
        case hourly
        case nextHour
        case alerts
    }

    let include: Set<Include>

#if os(Linux)
    func execute(_ request: HTTPClientRequest, timeout: TimeAmount) async throws -> HTTPClientResponse {

    }
#else
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        if include.contains(.availability) {
            return try! (encoder.encode(MockData.availability), URLResponse())
        } else {
            let apiWeather = APIWeather(
                currentWeather: include.contains(.current) ? MockData.currentWeather : nil,
                forecastDaily: include.contains(.daily) ? MockData.dailyWeather : nil,
                forecastHourly: include.contains(.hourly) ? MockData.hourlyWeather : nil,
                forecastNextHour: include.contains(.nextHour) ? MockData.nextHourWeather : nil,
                weatherAlerts: include.contains(.alerts) ? MockData.alerts : nil
            )

            return try! (encoder.encode(apiWeather), URLResponse())
        }
    }
#endif
}
