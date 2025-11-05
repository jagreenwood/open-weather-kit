//
//  AvailabilityView.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import SwiftUI
import OpenWeatherKit

/// Displays available weather datasets for a location
struct AvailabilityView: View {
    let availability: WeatherAvailability

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Available Datasets")
                .font(.headline)

            VStack(alignment: .leading, spacing: 8) {
                DatasetRow(name: "Current Weather", isAvailable: availability.alertAvailability == .available)
                DatasetRow(name: "Minute Forecast", isAvailable: availability.minuteAvailability == .available)
            }
        }
    }
}

/// Row showing availability status for a dataset
struct DatasetRow: View {
    let name: String
    let isAvailable: Bool

    var body: some View {
        HStack {
            Image(systemName: isAvailable ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(isAvailable ? .green : .red)
            Text(name)
                .font(.subheadline)
            Spacer()
            Text(isAvailable ? "Available" : "Not Available")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
