//
//  WeatherMethodType.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import Foundation

/// Represents all available WeatherService methods that can be demonstrated in the app
enum WeatherMethodType: String, CaseIterable, Identifiable {
    // MARK: - Forecast Methods
    case fullWeather = "Full Weather"
    case current = "Current Weather"
    case minute = "Minute Forecast"
    case hourly = "Hourly Forecast"
    case daily = "Daily Forecast"
    case alerts = "Weather Alerts"
    case availability = "Weather Availability"
    case changes = "Weather Changes"
    case historicalComparisons = "Historical Comparisons"

    // MARK: - Statistics Methods
    case dailyStatistics = "Daily Statistics"
    case dailyStatisticsRange = "Daily Statistics (Date Range)"
    case hourlyStatistics = "Hourly Statistics"
    case hourlyStatisticsRange = "Hourly Statistics (Date Range)"
    case monthlyStatistics = "Monthly Statistics"
    case monthlyStatisticsRange = "Monthly Statistics (Date Range)"

    // MARK: - Summary Methods
    case dailySummary = "Daily Summary"
    case dailySummaryRange = "Daily Summary (Date Range)"
    case dailySummaryDateInterval = "Daily Summary (Date Interval)"

    var id: String { rawValue }

    /// Display name for the method
    var displayName: String {
        rawValue
    }

    /// Category grouping for the method
    var category: String {
        switch self {
        case .fullWeather, .current, .minute, .hourly, .daily, .alerts, .availability, .changes, .historicalComparisons:
            return "Forecast"
        case .dailyStatistics, .dailyStatisticsRange, .hourlyStatistics, .hourlyStatisticsRange, .monthlyStatistics, .monthlyStatisticsRange:
            return "Statistics"
        case .dailySummary, .dailySummaryRange, .dailySummaryDateInterval:
            return "Summary"
        }
    }

    /// Brief description of what the method does
    var description: String {
        switch self {
        case .fullWeather:
            return "Returns complete weather data including all available datasets"
        case .current:
            return "Returns current weather conditions"
        case .minute:
            return "Returns minute-by-minute forecast for the next hour"
        case .hourly:
            return "Returns hourly forecast for the next 24 hours"
        case .daily:
            return "Returns daily forecast for the next 10 days"
        case .alerts:
            return "Returns active weather alerts for the location"
        case .availability:
            return "Returns available weather datasets for the location"
        case .changes:
            return "Returns information about significant weather changes"
        case .historicalComparisons:
            return "Returns comparisons to historical weather data"
        case .dailyStatistics:
            return "Returns daily weather statistics (30 days ago to 10 days out)"
        case .dailyStatisticsRange:
            return "Returns daily statistics for a specific date range"
        case .hourlyStatistics:
            return "Returns hourly weather statistics for current day"
        case .hourlyStatisticsRange:
            return "Returns hourly statistics for a specific date range"
        case .monthlyStatistics:
            return "Returns monthly weather statistics for all 12 months"
        case .monthlyStatisticsRange:
            return "Returns monthly statistics for a specific date range"
        case .dailySummary:
            return "Returns daily weather summary for the past 30 days"
        case .dailySummaryRange:
            return "Returns daily summary for a specific date range"
        case .dailySummaryDateInterval:
            return "Returns daily summary for a specific date interval"
        }
    }
}
