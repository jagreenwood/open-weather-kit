//
//  MethodListView.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import SwiftUI
import OpenWeatherKit

/// Main list view displaying all available WeatherService methods
/// Methods are grouped by category (Forecast, Statistics, Summary)
struct MethodListView: View {
    var viewModel: WeatherViewModel

    var body: some View {
        List {
            // Group methods by category
            ForEach(groupedMethods.keys.sorted(), id: \.self) { category in
                Section(header: Text(category)) {
                    ForEach(groupedMethods[category] ?? [], id: \.id) { method in
                        NavigationLink(value: method) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(method.displayName)
                                    .font(.headline)
                                Text(method.description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }

            // Footer with attribution and location info
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Demo Location")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("New York City (40.7128° N, 74.0060° W)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Divider()
                        .padding(.vertical, 4)

                    Text("Note")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("These methods demonstrate OpenWeatherKit's API. You must provide a valid Apple WeatherKit JWT token for the app to fetch real data.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Weather Methods")
        .navigationDestination(for: WeatherMethodType.self) { method in
            MethodDetailView(methodType: method, viewModel: viewModel)
        }
    }

    /// Groups methods by their category
    private var groupedMethods: [String: [WeatherMethodType]] {
        Dictionary(grouping: WeatherMethodType.allCases, by: { $0.category })
    }
}

#Preview {
    NavigationStack {
        MethodListView(
            viewModel: WeatherViewModel(
                configuration: WeatherService.Configuration(
                    jwt: { "preview-token" }
                )
            )
        )
    }
}
