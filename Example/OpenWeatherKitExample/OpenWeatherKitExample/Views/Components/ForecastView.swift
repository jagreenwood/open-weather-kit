//
//  ForecastView.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import SwiftUI
import OpenWeatherKit

/// Generic forecast display that works for hourly, daily, and minute forecasts
struct ForecastView<T>: View where T: Modelable {
    let forecast: Forecast<T>
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)

            // Metadata
            VStack(alignment: .leading, spacing: 4) {
                Text("Forecast Period")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(forecast.metadata.date.formatted(date: .abbreviated, time: .shortened))")
                    .font(.subheadline)
            }

            Divider()

            // Forecast items
            VStack(alignment: .leading, spacing: 8) {
                Text("Forecast Items: \(forecast.forecast.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if forecast.forecast.first is DayWeather {
                    let items = Array(forecast.forecast.prefix(5)).compactMap { $0 as? DayWeather }
                    ForEach(items, id: \.date) { day in
                        DayWeatherRow(dayWeather: day)
                    }
                } else if forecast.forecast.first is HourWeather {
                    let items = Array(forecast.forecast.prefix(8)).compactMap { $0 as? HourWeather }
                    ForEach(items, id: \.date) { hour in
                        HourWeatherRow(hourWeather: hour)
                    }
                } else if forecast.forecast.first is MinuteWeather {
                    Text("Minute-by-minute forecast for the next hour")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    let items = Array(forecast.forecast.prefix(12)).compactMap { $0 as? MinuteWeather }
                    ForEach(Array(items.enumerated()), id: \.element.date) { index, minute in
                        MinuteWeatherRow(minuteWeather: minute, minuteNumber: index)
                    }
                }

                var limit: Int {
                    if forecast.forecast.first is DayWeather {
                        return 5
                    } else if forecast.forecast.first is HourWeather {
                        return 8
                    } else if forecast.forecast.first is MinuteWeather {
                        return 12
                    } else {
                        return 5
                    }
                }

                if forecast.forecast.count > limit {
                    Text("Showing first few items. Total: \(forecast.forecast.count)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
            }
        }
    }
}

/// Row for displaying daily weather forecast
struct DayWeatherRow: View {
    let dayWeather: DayWeather

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(dayWeather.date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .fontWeight(.semibold)

            HStack {
                Text("High: \(formatTemp(dayWeather.highTemperature))")
                Text("•")
                    .foregroundColor(.secondary)
                Text("Low: \(formatTemp(dayWeather.lowTemperature))")
            }
            .font(.caption)

            Text(dayWeather.condition.description)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }

    private func formatTemp(_ measurement: Measurement<UnitTemperature>) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter.string(from: measurement)
    }
}

/// Row for displaying hourly weather forecast
struct HourWeatherRow: View {
    let hourWeather: HourWeather

    var body: some View {
        HStack {
            Text(hourWeather.date.formatted(date: .omitted, time: .shortened))
                .font(.subheadline)
                .frame(width: 80, alignment: .leading)

            Text(formatTemp(hourWeather.temperature))
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(width: 60, alignment: .leading)

            Text(hourWeather.condition.description)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }

    private func formatTemp(_ measurement: Measurement<UnitTemperature>) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter.string(from: measurement)
    }
}

/// Row for displaying minute weather forecast
struct MinuteWeatherRow: View {
    let minuteWeather: MinuteWeather
    let minuteNumber: Int

    var body: some View {
        HStack {
            Text("+\(minuteNumber) min")
                .font(.caption)
                .frame(width: 60, alignment: .leading)

            Text("Precipitation: \(Int(minuteWeather.precipitationIntensity.value * 100))%")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }
}

