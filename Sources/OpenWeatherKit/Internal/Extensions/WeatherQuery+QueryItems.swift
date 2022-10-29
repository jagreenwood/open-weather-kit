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

extension Array where Element == WeatherQuery<Any> {
    var queryItems: [URLQueryItem] {
        var dataSets: [String] = []
        var dailyStartDate: Date?
        var dailyEndDate: Date?
        var hourlyStateDate: Date?
        var hourlyEndDate: Date?
        var countryCode: String?

        for query in self {
            dataSets.append(query.dataSet)

            switch query.dataSet {
            case APIWeather.CodingKeys.forecastDaily.rawValue:
                dailyStartDate = query.startDate
                dailyEndDate = query.endDate
            case APIWeather.CodingKeys.forecastHourly.rawValue:
                hourlyStateDate = query.startDate
                hourlyEndDate = query.endDate
            case APIWeather.CodingKeys.weatherAlerts.rawValue:
                countryCode = query.countryCode
            default: break
            }
        }

        var queryItems = [
            URLQueryItem(name: "dataSets", value: dataSets.joined(separator: ","))
        ]

        if let dailyStartDate {
            queryItems.append(
                URLQueryItem(
                    name: "dailyStart",
                    value: isoFormatter.string(from: dailyStartDate))
            )
        }

        if let dailyEndDate {
            queryItems.append(
                URLQueryItem(
                    name: "dailyEnd",
                    value: isoFormatter.string(from: dailyEndDate))
            )
        }

        if let hourlyStateDate {
            queryItems.append(
                URLQueryItem(
                    name: "hourlyEnd",
                    value: isoFormatter.string(from: hourlyStateDate))
            )
        }

        if let hourlyEndDate {
            queryItems.append(
                URLQueryItem(
                    name: "hourlyEnd",
                    value: isoFormatter.string(from: hourlyEndDate))
            )
        }

        if let countryCode {
            queryItems.append(
                URLQueryItem(
                    name: "countryCode",
                    value: countryCode)
            )
        }

        return queryItems
    }
}
