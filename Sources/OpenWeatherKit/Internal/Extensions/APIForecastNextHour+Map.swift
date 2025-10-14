//
//  APIForecastNextHour+Map.swift
//
//
//  Created by Jeremy Greenwood on 10/25/22.
//

import Foundation

extension APIForecastNextHour {
    var minuteForecast: Forecast<MinuteWeather> {
        Forecast<MinuteWeather>(
            forecast: minutes.map { minute in
                minute.minuteWeather(condition.first(where: { $0.startTime == minute.startTime }))
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
