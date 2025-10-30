//
//  APIHourlyStatistics+Map.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension APIHourlyStatistics {
    @usableFromInline
    var hourlyTemperatureStatistics: HourlyWeatherStatistics<HourTemperatureStatistics> {
        HourlyWeatherStatistics<HourTemperatureStatistics>(
            hours: hours.map(\.temperatureStatistics),
            baselineStartDate: Date.daysFromEpoch(baselineStart),
            metadata: metadata.weatherMetadata
        )
    }

    @usableFromInline
    func parse<T>(query: HourlyWeatherStatisticsQuery<T>) -> HourlyWeatherStatistics<T> {
        switch query.statisticsType {
        case .temperature:
            guard let stats = hourlyTemperatureStatistics as? HourlyWeatherStatistics<T> else {
                preconditionFailure("Type mismatch: expected HourlyWeatherStatistics<HourTemperatureStatistics> but got HourlyWeatherStatistics<\(T.self)>")
            }
            return stats
        default:
            preconditionFailure("Invalid statistics type: HourlyWeatherStatistics<\(T.self)>")
        }
    }
}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension APIHourlyStatisticsData {
    @usableFromInline
    var temperatureStatistics: HourTemperatureStatistics {
        HourTemperatureStatistics(
            hour: hourOfYear,
            percentiles: Percentiles(
                p10: Measurement(value: temperature.p10 ?? 0.0, unit: .celsius),
                p50: Measurement(value: temperature.p50 ?? 0.0, unit: .celsius),
                p90: Measurement(value: temperature.p90 ?? 0.0, unit: .celsius)
            )
        )
    }
}
