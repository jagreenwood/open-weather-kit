//
//  StatisticsQuery.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/30/25.
//

import Foundation

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
@usableFromInline
protocol StatisticsQuery {
    var statisticsType: StatisticsType { get }
}

@usableFromInline
enum StatisticsType: Sendable {
    case precipitation
    case temperature

    @usableFromInline
    var dataSet: String {
        switch self {
        case .precipitation: "precipitation"
        case .temperature: "temperature"
        }
    }
}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
extension DailyWeatherStatisticsQuery: StatisticsQuery {}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
extension HourlyWeatherStatisticsQuery: StatisticsQuery {}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
extension MonthlyWeatherStatisticsQuery: StatisticsQuery {}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
extension DailyWeatherSummaryQuery: StatisticsQuery {}
