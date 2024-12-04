//
//  APIForecastHourly+Map.swift
//  
//
//  Created by Jeremy Greenwood on 10/25/22.
//

import Foundation

extension APIForecastHourly {
    var hourForecast: Forecast<HourWeather> {
        Forecast<HourWeather>(
            forecast: hours.map(\.hourWeather),
            metadata: metadata.weatherMetadata
        )
    }
}

extension APIHour {
    var hourWeather: HourWeather {
        HourWeather(
            date: forecastStart,
            cloudCover: cloudCover,
            condition: WeatherCondition(rawValue: conditionCode) ?? .undefined,
            symbolName: (WeatherCondition(rawValue: conditionCode) ?? .undefined).sfSymbol,
            dewPoint: Measurement(value: temperatureDewPoint, unit: .celsius),
            humidity: humidity,
            isDaylight: daylight,
            precipitation: Precipitation(rawValue: precipitationType) ?? .none,
            precipitationChance: precipitationChance,
            precipitationAmount: Measurement(value: precipitationAmount, unit: .millimeters),
            pressure: Measurement(value: pressure, unit: .millibars),
            pressureTrend: PressureTrend(rawValue: pressureTrend) ?? .undefined,
            snowfallIntensity: snowfallIntensity != nil ? Measurement(value: snowfallIntensity!, unit: .millimetersPerHour) : nil,
            snowfallAmount: snowfallAmount != nil ? Measurement(value: snowfallAmount!, unit: .millimeters) : nil,
            temperature: Measurement(value: temperature, unit: .celsius),
            apparentTemperature: Measurement(value: temperatureApparent, unit: .celsius),
            uvIndex: UVIndex(value: uvIndex, category: .init(value: uvIndex)),
            visibility: Measurement(value: visibility, unit: .meters),
            wind: Wind(
                compassDirection: Wind.CompassDirection(value: windDirection),
                direction: Measurement(value: Double(windDirection), unit: .degrees),
                speed: Measurement(value: windSpeed, unit: .kilometersPerHour))
        )
    }
}
