//
//  APIForecastDaily+Map.swift
//  
//
//  Created by Jeremy Greenwood on 10/25/22.
//

@preconcurrency import Foundation

extension APIForecastDaily {
    var dailyForecast: Forecast<DayWeather> {
        Forecast<DayWeather>(
            forecast: days.map(\.dayWeather),
            metadata: metadata.weatherMetadata
        )
    }
}

extension APIDay {
    var dayWeather: DayWeather {
        DayWeather(
            date: forecastStart,
            condition: WeatherCondition(rawValue: conditionCode) ?? .undefined,
            symbolName: (WeatherCondition(rawValue: conditionCode) ?? .undefined).sfSymbol,
            highTemperature: Measurement(value: temperatureMax, unit: .celsius),
            lowTemperature: Measurement(value: temperatureMin, unit: .celsius),
            precipitation: Precipitation(rawValue: precipitationType) ?? .none,
            precipitationChance: precipitationChance,
            rainfallAmount: Measurement(value: precipitationAmount, unit: .millimeters),
            snowfallAmount: Measurement(value: snowfallAmount, unit: .millimeters),
            sun: SunEvents(
                astronomicalDawn: sunriseAstronomical,
                nauticalDawn: sunriseNautical,
                civilDawn: sunriseCivil,
                sunrise: sunrise,
                solarNoon: solarNoon,
                sunset: sunset,
                civilDusk: sunsetCivil,
                nauticalDusk: sunsetNautical,
                astronomicalDusk: sunsetAstronomical,
                solarMidnight: solarMidnight
            ),
            moon: MoonEvents(
                phase: MoonPhase(rawValue: moonPhase)!,
                moonrise: moonrise,
                moonset: moonset
            ),
            uvIndex: UVIndex(value: maxUvIndex, category: .init(value: maxUvIndex)),
            wind: Wind(
                compassDirection: Wind.CompassDirection(value: daytimeForecast.windDirection),
                direction: Measurement(value: Double(daytimeForecast.windDirection), unit: .degrees),
                speed: Measurement(value: daytimeForecast.windSpeed, unit: .kilometersPerHour))
        )
    }
}
