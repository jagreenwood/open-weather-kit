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

struct NetworkClient {
    enum Constants {
        static let authorization = "Authorization"
        static let bearer = "Bearer"
    }

#if os(Linux)
    let httpClient: HTTPClient
#else
    let session: URLSession
#endif


    func fetchAvailability(
        location: Location,
        jwt: String
    ) async throws -> [APIWeatherAvailability] {
        try await get(.availability(location), jwt: jwt)
    }

    func fetchWeather(
        location: Location,
        language: WeatherService.Configuration.Language,
        queries: any Query...,
        jwt: String
    ) async throws -> WeatherProxy {
        try await withThrowingTaskGroup(of: WeatherProxy.self) { group in
            var _queries = queries

            if let index = _queries.firstIndex(where: { $0 is WeatherQuery<WeatherAvailability> }) {
                group.addTask {
                    let availability: [APIWeatherAvailability] = try await fetchAvailability(location: location, jwt: jwt)
                    return availability.weatherProxy
                }

                _queries.remove(at: index)
            }

            // if queries other than availability
            if !_queries.isEmpty {
                let queryItems = _queries.queryItems
                group.addTask {
                    let weather: APIWeather = try await get(
                        .weather(language,
                        location),
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
        let response = try await httpClient.execute(request, timeout: .seconds(30))
        let data = try await response.body.collect(upTo: 1024 * 1024)
#else
        var request = URLRequest(url: url)
        request.addValue("\(Constants.bearer) \(jwt)", forHTTPHeaderField: Constants.authorization)

        let (data, _) = try await session.data(for: request)
#endif

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(T.self, from: data)
    }
}
