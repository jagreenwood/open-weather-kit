//
//  APIDailySummary+Map.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
extension APIDailySummary {
    var dailyPrecipitationSummary: DailyWeatherSummary<DayPrecipitationSummary> {
        DailyWeatherSummary<DayPrecipitationSummary>(
            days: days.map(\.precipitationSummary),
            metadata: metadata.weatherMetadata
        )
    }

    var dailyTemperatureSummary: DailyWeatherSummary<DayTemperatureSummary> {
        DailyWeatherSummary(
            days: days.map(\.temperatureSummary),
            metadata: metadata.weatherMetadata
        )
    }

    @usableFromInline
    func parse<T>(query: DailyWeatherSummaryQuery<T>) -> DailyWeatherSummary<T> {
        switch query.statisticsType {
        case .temperature:
            guard let stats = dailyTemperatureSummary as? DailyWeatherSummary<T> else {
                preconditionFailure("Type mismatch: expected DailyWeatherSummary<DayTemperatureSummary> but got DailyWeatherSummary<\(T.self)>")
            }
            return stats
        case .precipitation:
            guard let stats = dailyPrecipitationSummary as? DailyWeatherSummary<T> else {
                preconditionFailure("Type mismatch: expected DailyWeatherSummary<DayPrecipitationSummary> but got DailyWeatherSummary<\(T.self)>")
            }
            return stats
        }
    }
}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
extension APIDailySummaryDay {
    var precipitationSummary: DayPrecipitationSummary {
        DayPrecipitationSummary(
            date: Date.daysFromEpoch(date),
            precipitationAmount: Measurement(value: precipitationAmount, unit: .millimeters),
            snowfallAmount: Measurement(value: snowfallAmount, unit: .millimeters)
        )
    }

    var temperatureSummary: DayTemperatureSummary {
        DayTemperatureSummary(
            date: Date.daysFromEpoch(date),
            lowTemperature: Measurement(value: temperatureMin, unit: .celsius),
            highTemperature: Measurement(value: temperatureMax, unit: .celsius)
        )
    }
}
