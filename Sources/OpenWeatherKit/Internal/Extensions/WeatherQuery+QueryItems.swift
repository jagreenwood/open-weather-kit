//
//  WeatherQuery+QueryItems.swift
//  
//
//  Created by Jeremy Greenwood on 10/28/22.
//

import Foundation

let isoFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime]

    return formatter
}()

extension Array where Element == any Query {
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        var dataSets: [String] = []

        for query in self {
            dataSets.append(query.queryType.dataSet)

            switch query.queryType {
            case let .alerts(dataSet: _, countryCode):
                queryItems.append(
                    URLQueryItem(
                        name: "country",
                        value: countryCode)
                )
            case let .daily(_, startDate, endDate):
                queryItems.append(
                    URLQueryItem(
                        name: "dailyStart",
                        value: isoFormatter.string(from: startDate))
                )

                queryItems.append(
                    URLQueryItem(
                        name: "dailyEnd",
                        value: isoFormatter.string(from: endDate))
                )
            case let .hourly(_, startDate, endDate):
                queryItems.append(
                    URLQueryItem(
                        name: "hourlyStart",
                        value: isoFormatter.string(from: startDate))
                )

                queryItems.append(
                    URLQueryItem(
                        name: "hourlyEnd",
                        value: isoFormatter.string(from: endDate))
                )
            default: break
            }
        }

        queryItems.append(URLQueryItem(name: "dataSets", value: dataSets.joined(separator: ",")))

        return queryItems
    }
}
