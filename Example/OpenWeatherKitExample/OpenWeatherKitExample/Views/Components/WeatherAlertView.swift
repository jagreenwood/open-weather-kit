//
//  WeatherAlertView.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import SwiftUI
import OpenWeatherKit

/// Displays weather alert information
struct WeatherAlertView: View {
    let alert: WeatherAlert

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Severity and source
            HStack {
                severityBadge
                Spacer()
                Text(alert.alert.source)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            // Summary
            Text(alert.alert.alertDescription)
                .font(.headline)

            // Details
            VStack(alignment: .leading, spacing: 8) {
                InfoRow(
                    label: "Effective",
                    value: alert.metadata.date.formatted(date: .abbreviated, time: .shortened)
                )

                InfoRow(
                    label: "Expires",
                    value: alert.metadata.expirationDate.formatted(date: .abbreviated, time: .shortened)
                )

                if let region = alert.alert.areaName {
                    InfoRow(label: "Region", value: region)
                }
            }
        }
        .padding()
        .background(severityBackgroundColor.opacity(0.1))
        .cornerRadius(8)
    }

    private var severityBadge: some View {
        Text(alert.alert.severity.rawValue.capitalized)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(severityColor)
            .foregroundColor(.white)
            .cornerRadius(4)
    }

    private var severityColor: Color {
        switch alert.alert.severity {
        case .extreme:
            return .red
        case .severe:
            return .orange
        case .moderate:
            return .yellow
        case .minor:
            return .blue
        case .unknown:
            return .gray
        }
    }

    private var severityBackgroundColor: Color {
        switch alert.alert.severity {
        case .extreme, .severe:
            return .red
        case .moderate:
            return .orange
        case .minor:
            return .blue
        case .unknown:
            return .gray
        }
    }
}
