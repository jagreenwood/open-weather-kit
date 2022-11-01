//
//  NetworkClient.swift
//  
//
//  Created by Jeremy Greenwood on 10/31/22.
//

import Foundation

struct NetworkClient {
    static func fetchAvailability(
        location: Location,
        jwt: String
    ) async throws -> [APIWeatherAvailability] {
        try await Self.get(.availability(location), jwt: jwt)
    }

    static func fetchWeather(
        location: Location,
        language: WeatherService.Configuration.Language,
        queries: any Query...,
        jwt: String
    ) async throws -> WeatherProxy {
        try await withThrowingTaskGroup(of: WeatherProxy.self) { group in
            // if queries other than availability
            if queries.contains(where: { !($0 is WeatherQuery<WeatherAvailability>) }) && queries.count > 1 {
                group.addTask {
                    let weather: APIWeather = try await Self.get(
                        .weather(language,
                        location),
                        queryItems: queries.queryItems,
                        jwt: jwt
                    )
                    return weather.weatherProxy
                }
            }

            if queries.contains(where: { $0 is WeatherQuery<WeatherAvailability> }) {
                group.addTask {
                    let availability: [APIWeatherAvailability] = try await fetchAvailability(location: location, jwt: jwt)
                    return availability.weatherProxy
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
    static func get<T>(
        _ route: Route,
        queryItems: [URLQueryItem] = [],
        jwt: String
    ) async throws -> T where T: Decodable {
        var components = URLComponents(url: route.url, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems

        let url = components?.url ?? route.url
        var request = URLRequest(url: url)
        request.addValue("Authorization", forHTTPHeaderField: "Bearer \(jwt)")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(T.self, from: data)
    }
}
