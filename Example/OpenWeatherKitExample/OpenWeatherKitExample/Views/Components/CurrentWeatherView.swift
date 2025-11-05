//
//  CurrentWeatherView.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import SwiftUI
import OpenWeatherKit

/// Displays current weather conditions
struct CurrentWeatherView: View {
    let currentWeather: CurrentWeather

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Temperature section
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Temperature")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(formatTemperature(currentWeather.temperature))
                        .font(.system(size: 48, weight: .bold))
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("Feels Like")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(formatTemperature(currentWeather.apparentTemperature))
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }

            Divider()

            // Conditions
            VStack(alignment: .leading, spacing: 8) {
                Text("Conditions")
                    .font(.headline)

                InfoRow(label: "Condition", value: currentWeather.condition.description)
                InfoRow(label: "Humidity", value: "\(Int(currentWeather.humidity * 100))%")
                InfoRow(label: "Pressure", value: String(format: "%.1f mb", currentWeather.pressure.value))
                InfoRow(label: "UV Index", value: "\(currentWeather.uvIndex.value)")
                InfoRow(label: "Visibility", value: String(format: "%.1f km", currentWeather.visibility.value / 1000))
            }

            Divider()

            // Wind
            VStack(alignment: .leading, spacing: 8) {
                Text("Wind")
                    .font(.headline)

                InfoRow(label: "Speed", value: String(format: "%.1f km/h", currentWeather.wind.speed.value))
                InfoRow(label: "Direction", value: "\(Int(currentWeather.wind.direction.value))°")
            }

            Divider()

            // Additional info
            VStack(alignment: .leading, spacing: 8) {
                Text("Additional Information")
                    .font(.headline)
                
                InfoRow(label: "Dew Point", value: formatTemperature(currentWeather.dewPoint))
                InfoRow(label: "Cloud Cover", value: "\(Int(currentWeather.cloudCover * 100))%")
            }

            // Timestamp
            Text("As of \(currentWeather.date.formatted(date: .abbreviated, time: .shortened))")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 8)
        }
    }

    private func formatTemperature(_ measurement: Measurement<UnitTemperature>) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter.string(from: measurement)
    }
}

/// Helper view for displaying label-value pairs
struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
        .font(.subheadline)
    }
}
