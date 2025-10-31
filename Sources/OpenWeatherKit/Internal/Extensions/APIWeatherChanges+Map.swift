//
//  APIWeatherChanges+Map.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/31/25.
//

import Foundation

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
extension APIWeatherChanges {
    var weatherChanges: WeatherChanges {
        WeatherChanges(
            changes: changes.map { $0.weatherChange },
            metadata: metadata.weatherMetadata
        )
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
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
