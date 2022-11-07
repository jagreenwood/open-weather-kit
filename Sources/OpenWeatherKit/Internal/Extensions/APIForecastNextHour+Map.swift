//
//  APIForecastNextHour+Map.swift
//  
//
//  Created by Jeremy Greenwood on 10/25/22.
//

@preconcurrency import Foundation

extension APIForecastNextHour {
    var minuteForecast: Forecast<MinuteWeather> {
        Forecast<MinuteWeather>(
            forecast: minutes.map(\.minuteWeather),
            metadata: metadata.weatherMetadata
        )
    }
}

extension APIMinute {
    var minuteWeather: MinuteWeather {
        MinuteWeather(
            date: startTime,
            precipitation: condition != nil ? (Precipitation(rawValue: condition!) ?? .none) : .none,
            precipitationChance: precipitationChance,
            precipitationIntensity: Measurement(value: precipitationIntensity, unit: .metersPerSecond)
        )
    }
}
