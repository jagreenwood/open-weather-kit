//
//  MethodDetailView.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import SwiftUI
import OpenWeatherKit

/// Detail view that executes and displays results for a selected weather method
struct MethodDetailView: View {
    let methodType: WeatherMethodType
    @ObservedObject var viewModel: WeatherViewModel
    @State private var showError = false

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                // Loading state
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.5)
                    Text("Fetching \(methodType.displayName)...")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            } else if let result = viewModel.result {
                // Success state - display results
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Result type header
                        Text(result.resultDescription)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top)

                        // Result content based on type
                        resultContentView(for: result)
                            .padding(.horizontal)

                        Spacer(minLength: 20)
                    }
                }
            } else if viewModel.error != nil {
                // Error state
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundColor(.orange)

                    Text("Unable to fetch weather data")
                        .font(.headline)

                    Text("Tap the info button for details")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Button("Retry") {
                        Task {
                            await viewModel.executeMethod(methodType)
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding(.top, 8)
                }
                .padding()
            } else {
                // Initial state (shouldn't normally be seen)
                VStack {
                    Text("Ready to fetch data")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle(methodType.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if viewModel.error != nil {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showError = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
        .alert("Error Details", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            if let error = viewModel.error {
                Text(error.localizedDescription)
            }
        }
        .task {
            // Execute method when view appears
            await viewModel.executeMethod(methodType)
        }
    }

    /// Returns the appropriate view for displaying the result
    @ViewBuilder
    private func resultContentView(for result: WeatherMethodResult) -> some View {
        switch result {
        case .weather(let weather):
            CurrentWeatherView(currentWeather: weather.currentWeather)
            Divider()
            Text("This result includes all available weather data. For demonstration purposes, showing current weather only. Use specific queries for other datasets.")
                .font(.caption)
                .foregroundColor(.secondary)

        case .currentWeather(let current):
            CurrentWeatherView(currentWeather: current)

        case .minuteForecast(let forecast):
            if let forecast = forecast {
                ForecastView(forecast: forecast, title: "Next Hour Forecast")
            } else {
                Text("Minute forecast not available for this location")
                    .foregroundColor(.secondary)
            }

        case .hourlyForecast(let forecast):
            ForecastView(forecast: forecast, title: "Hourly Forecast")

        case .dailyForecast(let forecast):
            ForecastView(forecast: forecast, title: "Daily Forecast")

        case .alerts(let alerts):
            if let alerts = alerts, !alerts.isEmpty {
                ForEach(alerts, id: \.alert.id) { alert in
                    WeatherAlertView(alert: alert)
                }
            } else {
                Text("No active weather alerts")
                    .foregroundColor(.secondary)
            }

        case .availability(let availability):
            AvailabilityView(availability: availability)

        case .changes(let changes):
            if let changes = changes, !changes.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Weather Changes Available")
                        .font(.headline)
                    Text("Forecast0: \(changes[0].date.formatted())")
                }
            } else {
                Text("No weather changes data available")
                    .foregroundColor(.secondary)
            }

        case .historicalComparisons(let comparisons):
            if let comparisons = comparisons {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Historical Comparisons Available")
                        .font(.headline)
                    Text("Contains \(comparisons.comparisons.count) comparison(s)")
                }
            } else {
                Text("No historical comparison data available")
                    .foregroundColor(.secondary)
            }

        case .dailyStatistics(let temp, let precip):
            StatisticsView(temperatureStats: temp, precipitationStats: precip, title: "Daily Statistics")

        case .hourlyStatistics(let temp):
            StatisticsView<HourTemperatureStatistics, Optional<HourTemperatureStatistics>>(temperatureStats: temp, precipitationStats: nil, title: "Hourly Statistics")

        case .monthlyStatistics(let temp, let precip):
            StatisticsView(temperatureStats: temp, precipitationStats: precip, title: "Monthly Statistics")

        case .dailySummary(let temp, let precip):
            SummaryView(temperatureSummary: temp, precipitationSummary: precip, title: "Daily Summary")
        }
    }
}

#Preview {
    NavigationStack {
        MethodDetailView(
            methodType: .current,
            viewModel: WeatherViewModel(
                configuration: WeatherService.Configuration(
                    jwt: { "preview-token" }
                )
            )
        )
    }
}
