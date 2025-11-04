//
//  WeatherViewModel.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import Combine
import Foundation
import OpenWeatherKit
import SwiftUI

/// ViewModel managing weather data fetching and state
@MainActor
class WeatherViewModel: ObservableObject {
    // MARK: - Properties

    /// The WeatherService instance used for all API calls
    private let weatherService: WeatherService

    /// Hardcoded NYC location for demo purposes
    /// This simplifies the example by avoiding location permissions
    private let nycLocation = Location(latitude: 40.7128, longitude: -74.0060)

    /// Loading state - true when an API call is in progress
    @Published var isLoading = false

    /// Error from the last API call, if any
    @Published var error: Error?

    /// Result from the last successful API call
    @Published var result: WeatherMethodResult?

    // MARK: - Initialization

    /// Initialize the ViewModel with a WeatherService configuration
    /// - Parameter configuration: WeatherService.Configuration with JWT provider
    init(configuration: WeatherService.Configuration) {
        self.weatherService = WeatherService(configuration: configuration)
    }

    // MARK: - Public Methods

    /// Execute a weather method based on the selected type
    /// - Parameter methodType: The weather method to execute
    func executeMethod(_ methodType: WeatherMethodType) async {
        // Reset state
        isLoading = true
        error = nil
        result = nil

        do {
            // Execute the appropriate method based on type
            let methodResult = try await performMethodCall(methodType)
            result = methodResult
        } catch {
            self.error = error
        }

        isLoading = false
    }

    // MARK: - Private Methods

    /// Performs the actual API call based on method type
    /// - Parameter methodType: The method type to execute
    /// - Returns: The result wrapped in WeatherMethodResult enum
    private func performMethodCall(_ methodType: WeatherMethodType) async throws -> WeatherMethodResult {
        switch methodType {
        // MARK: Forecast Methods
        case .fullWeather:
            let weather = try await weatherService.weather(for: nycLocation)
            return .weather(weather)

        case .current:
            let current = try await weatherService.weather(for: nycLocation, including: .current)
            return .currentWeather(current)

        case .minute:
            let minute = try await weatherService.weather(for: nycLocation, including: .minute)
            return .minuteForecast(minute)

        case .hourly:
            let hourly = try await weatherService.weather(for: nycLocation, including: .hourly)
            return .hourlyForecast(hourly)

        case .daily:
            let daily = try await weatherService.weather(for: nycLocation, including: .daily)
            return .dailyForecast(daily)

        case .alerts:
            let alerts = try await weatherService.weather(for: nycLocation, including: .alerts)
            return .alerts(alerts)

        case .availability:
            let availability = try await weatherService.weather(for: nycLocation, including: .availability)
            return .availability(availability)

        case .changes:
            let changes = try await weatherService.weather(for: nycLocation, including: .changes)
            return .changes(changes)

        case .historicalComparisons:
            let comparisons = try await weatherService.weather(for: nycLocation, including: .historicalComparisons)
            return .historicalComparisons(comparisons)

        // MARK: Statistics Methods
        case .dailyStatistics:
            // Request both temperature and precipitation statistics for default range
            let (temp, precip) = try await weatherService.dailyStatistics(
                for: nycLocation,
                including: .temperature, .precipitation
            )
            return .dailyStatistics(temp, precip)

        case .dailyStatisticsRange:
            // Example: Get statistics for days 1-10 of the year
            let now = Date()
            let calendar = Calendar.current
            let startDate = calendar.date(byAdding: .day, value: -30, to: now) ?? now
            let endDate = calendar.date(byAdding: .day, value: 10, to: now) ?? now
            let interval = DateInterval(start: startDate, end: endDate)

            let (temp, precip) = try await weatherService.dailyStatistics(
                for: nycLocation,
                forDaysIn: interval,
                including: .temperature, .precipitation
            )
            return .dailyStatistics(temp, precip)

        case .hourlyStatistics:
            // Get hourly temperature statistics for current day
            let temp = try await weatherService.hourlyStatistics(
                for: nycLocation,
                including: .temperature
            )
            return .hourlyStatistics(temp)

        case .hourlyStatisticsRange:
            // Example: Get statistics for specific hour range
            let now = Date()
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: now)
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) ?? startOfDay
            let interval = DateInterval(start: startOfDay, end: endOfDay)

            let temp = try await weatherService.hourlyStatistics(
                for: nycLocation,
                forHoursIn: interval,
                including: .temperature
            )
            return .hourlyStatistics(temp)

        case .monthlyStatistics:
            // Get monthly statistics for all 12 months
            let (temp, precip) = try await weatherService.monthlyStatistics(
                for: nycLocation,
                including: .temperature, .precipitation
            )
            return .monthlyStatistics(temp, precip)

        case .monthlyStatisticsRange:
            // Example: Get statistics for specific month range (Jan-Jun)
            let now = Date()
            let calendar = Calendar.current
            let startDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: now), month: 1, day: 1)) ?? now
            let endDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: now), month: 6, day: 30)) ?? now
            let interval = DateInterval(start: startDate, end: endDate)

            let (temp, precip) = try await weatherService.monthlyStatistics(
                for: nycLocation,
                forMonthsIn: interval,
                including: .temperature, .precipitation
            )
            return .monthlyStatistics(temp, precip)

        // MARK: Summary Methods
        case .dailySummary:
            // Get daily summary for past 30 days
            let (temp, precip) = try await weatherService.dailySummary(
                for: nycLocation,
                including: .temperature, .precipitation
            )
            return .dailySummary(temp, precip)

        case .dailySummaryRange:
            // Example: Get summary for specific day range (last 10 days)
            let now = Date()
            let calendar = Calendar.current
            let startDate = calendar.date(byAdding: .day, value: -10, to: now) ?? now

            let (temp, precip) = try await weatherService.dailySummary(
                for: nycLocation,
                startDay: calendar.ordinality(of: .day, in: .year, for: startDate) ?? 1,
                endDay: calendar.ordinality(of: .day, in: .year, for: now) ?? 365,
                including: .temperature, .precipitation
            )
            return .dailySummary(temp, precip)

        case .dailySummaryDateInterval:
            // Example: Get summary for specific date interval
            let now = Date()
            let calendar = Calendar.current
            let startDate = calendar.date(byAdding: .day, value: -15, to: now) ?? now
            let interval = DateInterval(start: startDate, end: now)

            let (temp, precip) = try await weatherService.dailySummary(
                for: nycLocation,
                forDaysIn: interval,
                including: .temperature, .precipitation
            )
            return .dailySummary(temp, precip)
        }
    }
}

// MARK: - Location Helper

/// Simple struct conforming to LocationProtocol for demo purposes
private struct Location: LocationProtocol {
    let latitude: Double
    let longitude: Double
}
