//
//  WeatherMethodResult.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import Foundation
import OpenWeatherKit

/// Wraps different return types from WeatherService methods
/// This enum allows us to handle the varying return types in a unified way
enum WeatherMethodResult {
    // MARK: - Forecast Results
    case weather(Weather)
    case currentWeather(CurrentWeather)
    case minuteForecast(Forecast<MinuteWeather>?)
    case hourlyForecast(Forecast<HourWeather>)
    case dailyForecast(Forecast<DayWeather>)
    case alerts([WeatherAlert]?)
    case availability(WeatherAvailability)
    case changes(WeatherChanges?)
    case historicalComparisons(HistoricalComparisons?)

    // MARK: - Statistics Results
    case dailyStatistics(DailyWeatherStatistics<DayTemperatureStatistics>, DailyWeatherStatistics<DayPrecipitationStatistics>)
    case hourlyStatistics(HourlyWeatherStatistics<HourTemperatureStatistics>)
    case monthlyStatistics(MonthlyWeatherStatistics<MonthTemperatureStatistics>, MonthlyWeatherStatistics<MonthPrecipitationStatistics>)

    // MARK: - Summary Results
    case dailySummary(DailyWeatherSummary<DayTemperatureSummary>, DailyWeatherSummary<DayPrecipitationSummary>)

    /// User-friendly description of the result type
    var resultDescription: String {
        switch self {
        case .weather:
            return "Complete Weather Data"
        case .currentWeather:
            return "Current Conditions"
        case .minuteForecast(let forecast):
            return forecast != nil ? "Minute Forecast (\(forecast!.forecast.count) minutes)" : "No Minute Forecast Available"
        case .hourlyForecast(let forecast):
            return "Hourly Forecast (\(forecast.forecast.count) hours)"
        case .dailyForecast(let forecast):
            return "Daily Forecast (\(forecast.forecast.count) days)"
        case .alerts(let alerts):
            return alerts != nil ? "Weather Alerts (\(alerts!.count))" : "No Active Alerts"
        case .availability:
            return "Dataset Availability"
        case .changes(let changes):
            return changes != nil ? "Weather Changes Available" : "No Weather Changes Data"
        case .historicalComparisons(let comparisons):
            return comparisons != nil ? "Historical Comparisons Available" : "No Historical Comparison Data"
        case .dailyStatistics:
            return "Daily Temperature & Precipitation Statistics"
        case .hourlyStatistics:
            return "Hourly Temperature Statistics"
        case .monthlyStatistics:
            return "Monthly Temperature & Precipitation Statistics"
        case .dailySummary:
            return "Daily Temperature & Precipitation Summary"
        }
    }
}
