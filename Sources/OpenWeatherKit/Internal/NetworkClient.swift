//
//  NetworkClient.swift
//
//
//  Created by Jeremy Greenwood on 10/31/22.
//

import Foundation
#if os(Linux)
import AsyncHTTPClient
import NIOCore
import NIOFoundationCompat
#endif

@usableFromInline
struct NetworkClient: Sendable {
    enum Constants {
        static let authorization = "Authorization"
        static let bearer = "Bearer"
    }

    let client: Client

    @usableFromInline
    func fetchAvailability(
        location: LocationProtocol,
        countryCode: String,
        jwt: String
    ) async throws -> [APIWeatherAvailability] {
        try await get(
            .availability(location),
            queryItems: [URLQueryItem(name: QueryContants.country, value: countryCode)],
            jwt: jwt
        )
    }

    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @usableFromInline
    func fetchDailySummary<each Q: StatisticsQuery>(
        location: LocationProtocol,
        dataSets: repeat each Q,
        startDate: Date,
        endDate: Date,
        jwt: String
    ) async throws -> APIDailySummary {
        var names: [String] = []
        repeat names.append((each dataSets).statisticsType.dataSet)

        let queryItems = [
            URLQueryItem(name: "dataSets", value: names.joined(separator: ",")),
            URLQueryItem(name: "start", value: startDate.toDateString()),
            URLQueryItem(name: "end", value: endDate.toDateString())
        ]

        return try await get(
            .dailySummary(location),
            queryItems: queryItems,
            jwt: jwt
        )
    }

    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @usableFromInline
    func fetchHourlyStatistics<each Q: StatisticsQuery>(
        location: LocationProtocol,
        dataSets: repeat each Q,
        startHour: Int,
        endHour: Int,
        jwt: String
    ) async throws -> APIHourlyStatistics {
        var names: [String] = []
        repeat names.append((each dataSets).statisticsType.dataSet)

        let queryItems = [
            URLQueryItem(name: "dataSets", value: names.joined(separator: ",")),
            URLQueryItem(name: "startHour", value: "\(startHour)"),
            URLQueryItem(name: "endHour", value: "\(endHour)")
        ]

        return try await get(
            .statistics(.hourly, location),
            queryItems: queryItems,
            jwt: jwt
        )
    }

    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @usableFromInline
    func fetchDailyStatistics<each Q: StatisticsQuery>(
        location: LocationProtocol,
        dataSets: repeat each Q,
        startDay: Int,
        endDay: Int,
        jwt: String
    ) async throws -> APIDailyStatistics {
        var names: [String] = []
        repeat names.append((each dataSets).statisticsType.dataSet)

        let queryItems = [
            URLQueryItem(name: "dataSets", value: names.joined(separator: ",")),
            URLQueryItem(name: "startDay", value: "\(startDay)"),
            URLQueryItem(name: "endDay", value: "\(endDay)")
        ]
        
        return try await get(
            .statistics(.daily, location),
            queryItems: queryItems,
            jwt: jwt
        )
    }

    @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
    @usableFromInline
    func fetchMonthlyStatistics<each Q: StatisticsQuery>(
        location: LocationProtocol,
        dataSets: repeat each Q,
        startMonth: Int,
        endMonth: Int,
        jwt: String
    ) async throws -> APIMonthlyStatistics {
        var names: [String] = []
        repeat names.append((each dataSets).statisticsType.dataSet)

        let queryItems = [
            URLQueryItem(name: "dataSets", value: names.joined(separator: ",")),
            URLQueryItem(name: "startMonth", value: "\(startMonth)"),
            URLQueryItem(name: "endMonth", value: "\(endMonth)")
        ]

        return try await get(
            .statistics(.monthly, location),
            queryItems: queryItems,
            jwt: jwt
        )
    }

    @usableFromInline
    func fetchWeather(
        location: LocationProtocol,
        language: WeatherService.Configuration.Language,
        queries: Query...,
        timezone: TimeZone,
        jwt: String
    ) async throws -> WeatherProxy {
        try await withThrowingTaskGroup(of: WeatherProxy.self) { group in
            var _queries = queries

            if let index = _queries.firstIndex(where: { $0 is WeatherQuery<WeatherAvailability> }) {
                guard case let .availability(_, countryCode) = _queries[index].queryType else {
                    preconditionFailure("Invalid QueryType on WeatherQuery<WeatherAvailability>")
                }

                group.addTask {
                    let availability: [APIWeatherAvailability] = try await fetchAvailability(
                        location: location,
                        countryCode: countryCode,
                        jwt: jwt)
                    return availability.weatherProxy
                }

                _queries.remove(at: index)
            }

            // if queries other than availability
            if !_queries.isEmpty {
                let queryItems = _queries.queryItems

                group.addTask {
                    // add timezone query item
                    var queryItems = queryItems
                    queryItems.append(
                        URLQueryItem(
                            name: QueryContants.timezone,
                            value: timezone.identifier
                        )
                    )

                    let weather: APIWeather = try await get(
                        .weather(language, location),
                        queryItems: queryItems,
                        jwt: jwt
                    )
                    return weather.weatherProxy
                }
            }

            var weatherProxy = WeatherProxy.empty

            for try await proxy in group {
                weatherProxy = weatherProxy.combined(with: proxy)
            }

            return weatherProxy
        }
    }
}

extension NetworkClient {
    func get<T>(
        _ route: Route,
        queryItems: [URLQueryItem] = [],
        jwt: String
    ) async throws -> T where T: Decodable {
        let url: URL = {
            guard !queryItems.isEmpty else {
                return route.url
            }

            var components = URLComponents(url: route.url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems

            return components?.url ?? route.url
        }()

#if os(Linux)
        var request = HTTPClientRequest(url: url.absoluteString)
        request.headers.add(name: Constants.authorization, value: "\(Constants.bearer) \(jwt)")
        let response = try await client.execute(request, timeout: .seconds(30))
        let data = try await response.body.collect(upTo: 1024 * 1024)
#else
        var request = URLRequest(url: url)
        request.addValue("\(Constants.bearer) \(jwt)", forHTTPHeaderField: Constants.authorization)

        let (data, _) = try await client.data(request)
#endif

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        return try decoder.decode(T.self, from: data)
    }
}
