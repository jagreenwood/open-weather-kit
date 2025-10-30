//
//  StatisticsQuery.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/30/25.
//

import Foundation

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
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

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension DailyWeatherStatisticsQuery: StatisticsQuery {}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension HourlyWeatherStatisticsQuery: StatisticsQuery {}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension MonthlyWeatherStatisticsQuery: StatisticsQuery {}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension DailyWeatherSummaryQuery: StatisticsQuery {}
