//
//  APIWeatherChanges+Map.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/31/25.
//

import Foundation

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
extension APIWeatherChanges {
    var weatherChanges: WeatherChanges {
        WeatherChanges(
            changes: changes.map { $0.weatherChange },
            metadata: metadata.weatherMetadata
        )
    }
}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
extension APIChange {
    var weatherChange: WeatherChange {
        WeatherChange(
            date: forecastStart,
            highTemperature: WeatherChange.Direction(rawValue: maxTemperatureChange) ?? .steady,
            lowTemperature: WeatherChange.Direction(rawValue: minTemperatureChange) ?? .steady,
            dayPrecipitationAmount: WeatherChange.Direction(rawValue: dayPrecipitationChange) ?? .steady,
            nightPrecipitationAmount: WeatherChange.Direction(rawValue: nightPrecipitationChange) ?? .steady
        )
    }
}
