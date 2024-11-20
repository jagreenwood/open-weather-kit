//
//  APICurrentWeather+Map.swift
//  
//
//  Created by Jeremy Greenwood on 10/25/22.
//

import Foundation

extension APICurrentWeather {
    var currentWeather: CurrentWeather {
        CurrentWeather(
            date: asOf,
            cloudCover: cloudCover,
            condition: WeatherCondition(rawValue: conditionCode) ?? .undefined,
            symbolName: (WeatherCondition(rawValue: conditionCode) ?? .undefined).sfSymbol,
            dewPoint: Measurement(value: temperatureDewPoint, unit: .celsius),
            humidity: humidity,
            percipationIntensity: Measurement(value: precipitationIntensity, unit: .millimetersPerHour),
            pressure: Measurement(value: pressure, unit: .millibars),
            pressureTrend: PressureTrend(rawValue: pressureTrend) ?? .undefined,
            isDaylight: daylight,
            temperature: Measurement(value: temperature, unit: .celsius),
            apparentTemperature: Measurement(value: temperatureApparent, unit: .celsius),
            uvIndex: UVIndex(value: uvIndex, category: UVIndex.ExposureCategory(value: uvIndex)),
            visibility: Measurement(value: visibility, unit: .meters),
            wind: Wind(
                compassDirection: Wind.CompassDirection(value: windDirection),
                direction: Measurement(value: Double(windDirection), unit: .degrees),
                speed: Measurement(value: windSpeed, unit: .kilometersPerHour)),
            metadata: metadata.weatherMetadata
        )
    }
}
