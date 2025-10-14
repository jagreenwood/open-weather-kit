//
//  APIForecastNextHour+Map.swift
//
//
//  Created by Jeremy Greenwood on 10/25/22.
//

import Foundation

extension APIForecastNextHour {
    var minuteForecast: Forecast<MinuteWeather> {
        var _conditions = condition
        var _condition: APICondition? = nil

        return Forecast<MinuteWeather>(
            forecast: minutes.map { minute in
                // Find the condition that applies to this minute, if any.
                // Conditions are sorted by start time, so we can just check the first one.
                // If it applies, remove it from the list so we don't check it again.
                // This assumes that conditions do not overlap.
                if let condition = _conditions.first, condition.startTime <= minute.startTime {
                    _condition = condition
                    _conditions.removeFirst()
                }

                // Map the minute and its condition to a MinuteWeather.
                return minute.minuteWeather(_condition)
            },
            metadata: metadata.weatherMetadata
        )
    }
}

extension APIMinute {
    func minuteWeather(_ condition: APICondition?) -> MinuteWeather {
        MinuteWeather(
            date: startTime,
            precipitation: condition != nil ? (Precipitation(rawValue: condition!.beginCondition) ?? .none) : .none,
            precipitationChance: precipitationChance,
            precipitationIntensity: Measurement(value: precipitationIntensity, unit: .metersPerSecond)
        )
    }
}
