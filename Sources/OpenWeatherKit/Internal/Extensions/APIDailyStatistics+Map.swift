//
//  APIDailyStatistics+Map.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension APIDailyStatistics {
    var dailyPrecipitationStatistics: DailyWeatherStatistics<DayPrecipitationStatistics> {
        DailyWeatherStatistics<DayPrecipitationStatistics>(
            days: days.map(\.precipitationStatistics),
            baselineStartDate: Date.daysFromEpoch(baselineStart),
            metadata: metadata.weatherMetadata
        )
    }

    var dailyTemperatureStatistics: DailyWeatherStatistics<DayTemperatureStatistics> {
        DailyWeatherStatistics<DayTemperatureStatistics>(
            days: days.map(\.temperatureStatistics),
            baselineStartDate: Date.daysFromEpoch(baselineStart),
            metadata: metadata.weatherMetadata
        )
    }

    @usableFromInline
    func parse<T>(query: DailyWeatherStatisticsQuery<T>) -> DailyWeatherStatistics<T> {
        switch query.statisticsType {
        case .temperature:
            guard let stats = dailyTemperatureStatistics as? DailyWeatherStatistics<T> else {
                preconditionFailure("Type mismatch: expected DailyWeatherStatistics<DayTemperatureStatistics> but got DailyWeatherStatistics<\(T.self)>")
            }
            return stats
        case .precipitation:
            guard let stats = dailyPrecipitationStatistics as? DailyWeatherStatistics<T> else {
                preconditionFailure("Type mismatch: expected DailyWeatherStatistics<DayPrecipitationStatistics> but got DailyWeatherStatistics<\(T.self)>")
            }
            return stats
        }
    }
}

@available(iOS 18.0, *)
extension APIDailyStatisticsData {
    var precipitationStatistics: DayPrecipitationStatistics {
        guard let precipitation else {
            preconditionFailure("Precipitation is nil, this could be a logic error")
        }

        return DayPrecipitationStatistics(
            day: dayOfYear,
            averagePrecipitationProbability: Double(precipitation.probability),
            averagePrecipitationAmount: Measurement(value: precipitation.averageAmount, unit: .millimeters),
            averageSnowfallAmount: Measurement(value: precipitation.averageSnowfallAmount, unit: .millimeters)
        )
    }

    var temperatureStatistics: DayTemperatureStatistics {
        guard let temperature else {
            preconditionFailure("Temperature is nil, this could be a logic error")
        }

        return DayTemperatureStatistics(
            day: dayOfYear,
            averageLowTemperature: Measurement(value: temperature.min ?? .nan, unit: .celsius),
            averageHighTemperature: Measurement(value: temperature.max ?? .nan, unit: .celsius)
        )
    }
}

