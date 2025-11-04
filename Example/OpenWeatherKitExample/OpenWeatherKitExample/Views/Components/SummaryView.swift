//
//  SummaryView.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import SwiftUI
import OpenWeatherKit

/// Displays daily weather summary information
struct SummaryView: View {
    let temperatureSummary: DailyWeatherSummary<DayTemperatureSummary>
    let precipitationSummary: DailyWeatherSummary<DayPrecipitationSummary>
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)

            // Temperature Summary Section
            VStack(alignment: .leading, spacing: 12) {
                Text("Temperature Summary")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Summary Period: \(temperatureSummary.days.count) days")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if let firstDay = temperatureSummary.days.first {
                        Text("Sample Day Summary:")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.top, 4)

                        InfoRow(label: "Max Temperature", value: formatTemperature(firstDay.highTemperature))
                        InfoRow(label: "Min Temperature", value: formatTemperature(firstDay.lowTemperature))
                    }

                    Text("Showing sample from \(temperatureSummary.days.count) day(s) of summary data")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
            }

            Divider()

            // Precipitation Summary Section
            VStack(alignment: .leading, spacing: 12) {
                Text("Precipitation Summary")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Summary Period: \(precipitationSummary.days.count) days")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if let firstDay = precipitationSummary.days.first {
                        Text("Sample Day Summary:")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.top, 4)

                        InfoRow(label: "Total Precipitation", value: String(format: "%.1f mm", firstDay.precipitationAmount.value))
                    }

                    Text("Showing sample from \(precipitationSummary.days.count) day(s) of summary data")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
            }
        }
    }

    private func formatTemperature(_ measurement: Measurement<UnitTemperature>) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter.string(from: measurement)
    }
}
