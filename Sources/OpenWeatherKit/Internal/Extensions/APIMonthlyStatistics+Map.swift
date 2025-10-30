//
//  APIMonthlyStatistics+Map.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension APIMonthlyStatistics {
    var monthlyPrecipitationStatistics: MonthlyWeatherStatistics<MonthPrecipitationStatistics> {
        MonthlyWeatherStatistics(
            months: months.map(\.precipitationStatistics),
            baselineStartDate: Date.daysFromEpoch(baselineStart),
            metadata: metadata.weatherMetadata
        )
    }

    var monthlyTemperatureStatistics: MonthlyWeatherStatistics<MonthTemperatureStatistics> {
        MonthlyWeatherStatistics(
            months: months.map(\.temperatureStatistics),
            baselineStartDate: Date.daysFromEpoch(baselineStart),
            metadata: metadata.weatherMetadata
        )
    }

    @usableFromInline
    func parse<T>(query: MonthlyWeatherStatisticsQuery<T>) -> MonthlyWeatherStatistics<T> {
        switch query.statisticsType {
        case .temperature:
            guard let stats = monthlyTemperatureStatistics as? MonthlyWeatherStatistics<T> else {
                preconditionFailure("Type mismatch: expected MonthlyWeatherStatistics<MonthTemperatureStatistics> but got MonthlyWeatherStatistics<\(T.self)>")
            }
            return stats
        case .precipitation:
            guard let stats = monthlyPrecipitationStatistics as? MonthlyWeatherStatistics<T> else {
                preconditionFailure("Type mismatch: expected MonthlyWeatherStatistics<MonthPrecipitationStatistics> but got MonthlyWeatherStatistics<\(T.self)>")
            }
            return stats
        }
    }
}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension APIMonthlyStatisticsData {
    var precipitationStatistics: MonthPrecipitationStatistics {
        guard let precipitation else {
            preconditionFailure("Precipitation is nil, this could be a logic error")
        }

        return MonthPrecipitationStatistics(
            month: month,
            averagePrecipitationProbability: Double(precipitation.probability),
            averagePrecipitationAmount: Measurement(value: precipitation.averageAmount, unit: .millimeters),
            averageSnowfallAmount: Measurement(value: precipitation.averageSnowfallAmount, unit: .millimeters)
        )
    }

    var temperatureStatistics: MonthTemperatureStatistics {
        guard let temperature else {
            preconditionFailure("Temperature is nil, this could be a logic error")
        }

        return MonthTemperatureStatistics(
            month: month,
            averageLowTemperature: Measurement(value: temperature.min ?? .nan, unit: .celsius),
            averageHighTemperature: Measurement(value: temperature.max ?? .nan, unit: .celsius)
        )
    }
}
