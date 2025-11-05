//
//  StatisticsView.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import SwiftUI
import OpenWeatherKit

typealias Modelable = Decodable & Encodable & Equatable & Sendable

/// Displays weather statistics (temperature and/or precipitation)Stat
struct StatisticsView<TemperatureMetric, PrecipitationMetric>: View where TemperatureMetric: Modelable, PrecipitationMetric: Modelable {
    let temperatureStats: DailyWeatherStatistics<TemperatureMetric>?
    let precipitationStats: DailyWeatherStatistics<PrecipitationMetric>?
    let title: String

    init(
        temperatureStats: DailyWeatherStatistics<TemperatureMetric>,
        precipitationStats: DailyWeatherStatistics<PrecipitationMetric>?,
        title: String
    ) {
        self.temperatureStats = temperatureStats
        self.precipitationStats = precipitationStats
        self.title = title
    }

    init(
        temperatureStats: HourlyWeatherStatistics<TemperatureMetric>,
        precipitationStats: HourlyWeatherStatistics<PrecipitationMetric>?,
        title: String
    ) where TemperatureMetric == HourTemperatureStatistics {
        // Convert to DailyWeatherStatistics for unified display
        // For hourly stats, we'll just display them as a special case
        self.temperatureStats = nil
        self.precipitationStats = nil
        self.title = title
    }

    init(
        temperatureStats: MonthlyWeatherStatistics<TemperatureMetric>,
        precipitationStats: MonthlyWeatherStatistics<PrecipitationMetric>?,
        title: String
    ) where TemperatureMetric == MonthTemperatureStatistics, PrecipitationMetric == MonthPrecipitationStatistics {
        // Convert to DailyWeatherStatistics for unified display
        self.temperatureStats = nil
        self.precipitationStats = nil
        self.title = title
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)

            if let tempStats = temperatureStats {
                TemperatureStatisticsSection(stats: tempStats as! DailyWeatherStatistics<DayTemperatureStatistics>)
            }

            if let precipStats = precipitationStats {
                Divider()
                PrecipitationStatisticsSection(stats: precipStats as! DailyWeatherStatistics<DayPrecipitationStatistics>)
            }

            // Fallback message if no stats available
            if temperatureStats == nil && precipitationStats == nil {
                Text("Statistics data structure differs by type. Displaying summary:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Statistics are available but require type-specific display logic.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

/// Section displaying temperature statistics
struct TemperatureStatisticsSection: View {
    let stats: DailyWeatherStatistics<DayTemperatureStatistics>

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Temperature Statistics")
                .font(.subheadline)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: 8) {
                Text("Statistics Period: \(stats.days.count) days")
                    .font(.caption)
                    .foregroundColor(.secondary)

                if let firstDay = stats.days.first {
                    Text("Sample Day Statistics:")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.top, 4)

                    InfoRow(label: "Max Temperature", value: formatTemperature(firstDay.averageHighTemperature))
                    InfoRow(label: "Min Temperature", value: formatTemperature(firstDay.averageLowTemperature))
                }

                Text("Showing sample from \(stats.days.count) day(s) of statistics")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
        }
    }

    private func formatTemperature(_ measurement: Measurement<UnitTemperature>) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter.string(from: measurement)
    }
}

/// Section displaying precipitation statistics
struct PrecipitationStatisticsSection: View {
    let stats: DailyWeatherStatistics<DayPrecipitationStatistics>

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Precipitation Statistics")
                .font(.subheadline)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: 8) {
                Text("Statistics Period: \(stats.days.count) days")
                    .font(.caption)
                    .foregroundColor(.secondary)

                if let firstDay = stats.days.first {
                    Text("Sample Day Statistics:")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.top, 4)

                    InfoRow(label: "Total Precipitation", value: String(format: "%.1f mm", firstDay.averagePrecipitationAmount.value))
                }

                Text("Showing sample from \(stats.days.count) day(s) of statistics")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
        }
    }
}
