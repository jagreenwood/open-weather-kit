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
        case alerts
        case changes
        case current
        case daily
        case historicalComparisons
        case hourly
        case nextHour
    }

    var include: Set<Include>

#if os(Linux)
    func execute(_ request: HTTPClientRequest, timeout: TimeAmount) async throws -> HTTPClientResponse {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970

        let buffer: ByteBuffer = {
            if request.url.contains("/availability/") {
                return try! encoder.encodeAsByteBuffer(
                    MockData.availability,
                    allocator: .init()
                )
            } else if request.url.contains("/weather/") {
                return try! encoder.encodeAsByteBuffer(
                    Self.apiWeather(with: include),
                    allocator: .init()
                )
            } else if request.url.contains("/summary/") {
                return try! encoder.encodeAsByteBuffer(
                    MockData.dailySummary,
                    allocator: .init()
                )
            } else if request.url.contains("/statistics/hourly/") {
                return try! encoder.encodeAsByteBuffer(
                    MockData.hourlyStatistics,
                    allocator: .init()
                )
            } else if request.url.contains("/statistics/daily/") {
                return try! encoder.encodeAsByteBuffer(
                    MockData.dailyStatistics,
                    allocator: .init()
                )
            } else if request.url.contains("/statistics/monthly/") {
                return try! encoder.encodeAsByteBuffer(
                    MockData.monthlyStatistics,
                    allocator: .init()
                )
            } else {
                preconditionFailure("Unknown URL: \(request.url)")
            }
        }()

        return HTTPClientResponse(body: .bytes(buffer))
    }

    func shutdown() async throws {}
#else
    func data(_ request: URLRequest) async throws -> (Data, URLResponse) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970

        let data: Data = {
            if request.url!.absoluteString.contains("/availability/") {
                return try! encoder.encode(MockData.availability)
            } else if request.url!.absoluteString.contains("/weather/") {
                return try! encoder.encode(Self.apiWeather(with: include))
            } else if request.url!.absoluteString.contains("/summary/") {
                return try! encoder.encode(MockData.dailySummary)
            } else if request.url!.absoluteString.contains("/statistics/hourly/") {
                return try! encoder.encode(MockData.hourlyStatistics)
            } else if request.url!.absoluteString.contains("/statistics/daily/") {
                return try! encoder.encode(MockData.dailyStatistics)
            } else if request.url!.absoluteString.contains("/statistics/monthly/") {
                return try! encoder.encode(MockData.monthlyStatistics)
            } else {
                preconditionFailure("Unknown URL: \(request.url!.absoluteString)")
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
            historicalComparisons: include.contains(.nextHour) ? MockData.historicalComparisons : nil,
            weatherAlerts: include.contains(.alerts) ? MockData.alerts : nil,
            weatherChanges: include.contains(.nextHour) ? MockData.changes : nil
        )
    }
}
