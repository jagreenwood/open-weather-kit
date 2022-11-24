//
//  MockClient.swift
//  
//
//  Created by Jeremy Greenwood on 11/9/22.
//

import Foundation
@testable import OpenWeatherKit
#if os(Linux)
import AsyncHTTPClient
import NIOCore
import NIOFoundationCompat
#endif

actor MockClient: Client {
    internal init(include: Set<MockClient.Include>) {
        self.include = include
    }

    enum Include: CaseIterable {
        case availability
        case current
        case daily
        case hourly
        case nextHour
        case alerts
    }

    var include: Set<Include>

#if os(Linux)
    func execute(_ request: HTTPClientRequest, timeout: TimeAmount) async throws -> HTTPClientResponse {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let buffer: ByteBuffer = {
            if include.contains(.availability) {
                include.remove(.availability)
                return try! encoder.encodeAsByteBuffer(
                    MockData.availability,
                    allocator: .init()
                )
            } else {
                return try! encoder.encodeAsByteBuffer(
                    Self.apiWeather(with: include),
                    allocator: .init()
                )
            }
        }()

        return HTTPClientResponse(body: .bytes(buffer))
    }

    func shutdown() async throws {}
#else
    func data(_ request: URLRequest) async throws -> (Data, URLResponse) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let data: Data = {
            if include.contains(.availability) {
                include.remove(.availability)
                return try! encoder.encode(MockData.availability)
            } else {
                return try! encoder.encode(Self.apiWeather(with: include))
            }
        }()

        return (data, URLResponse())
    }
#endif

    static func apiWeather(with include: Set<Include>) -> APIWeather {
        APIWeather(
            currentWeather: include.contains(.current) ? MockData.currentWeather : nil,
            forecastDaily: include.contains(.daily) ? MockData.dailyWeather : nil,
            forecastHourly: include.contains(.hourly) ? MockData.hourlyWeather : nil,
            forecastNextHour: include.contains(.nextHour) ? MockData.nextHourWeather : nil,
            weatherAlerts: include.contains(.alerts) ? MockData.alerts : nil
        )
    }
}
