//
//  APIForecastDaily+Map.swift
//  
//
//  Created by Jeremy Greenwood on 10/25/22.
//

import Foundation

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
            highTemperatureTime: temperatureMaxTime,
            lowTemperature: Measurement(value: temperatureMin, unit: .celsius),
            lowTemperatureTime: temperatureMinTime,
            maximumHumidity: humidityMax.percentage,
            minimumHumidity: humidityMin.percentage,
            precipitation: Precipitation(rawValue: precipitationType) ?? .none,
            precipitationChance: precipitationChance.percentage,
            precipitationAmountByType: precipitationAmountByType.precipitationAmountByType,
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
            maximumVisibility: visibilityMax,
            minimumVisibility: visibilityMin,
            wind: Wind(
                compassDirection: Wind.CompassDirection(value: Double(daytimeForecast.windDirection)),
                direction: Measurement(value: Double(daytimeForecast.windDirection), unit: .degrees),
                speed: Measurement(value: windSpeedAvg, unit: .kilometersPerHour),
                gust: Measurement(value: windGustSpeedMax, unit: .kilometersPerHour)
            ),
            highWindSpeed: Measurement(value: windSpeedMax, unit: .kilometersPerHour),
            daytimeForecast: daytimeForecast.dayPartForecast,
            overnightForecast: overnightForecast.dayPartForecast,
            restOfDayForecast: restOfDayForecast?.dayPartForecast
        )
    }
}

extension APIForecast {
    var dayPartForecast: DayPartForecast {
        DayPartForecast(
            cloudCover: cloudCover.percentage,
            cloudCoverByAltitude: CloudCoverByAltitude(
                low: cloudCoverLowAltPct.percentage,
                medium: cloudCoverMidAltPct.percentage,
                high: cloudCoverHighAltPct.percentage
            ),
            condition: WeatherCondition(rawValue: conditionCode) ?? .undefined,
            highTemperature: Measurement(value: temperatureMax, unit: .celsius),
            lowTemperature: Measurement(value: temperatureMin, unit: .celsius),
            precipitation: Precipitation(rawValue: precipitationType) ?? .none,
            precipitationAmountByType: precipitationAmountByType.precipitationAmountByType,
            precipitationChance: precipitationChance.percentage,
            maximumHumidity: humidityMax.percentage,
            minimumHumidity: humidityMin.percentage,
            maximumVisibility: Measurement(value: visibilityMax, unit: .meters),
            minimumVisibility: Measurement(value: visibilityMin, unit: .meters),
            wind: Wind(
                compassDirection: Wind.CompassDirection(value: Double(windDirection)),
                direction: Measurement(value: Double(windDirection), unit: .degrees),
                speed: Measurement(value: windSpeed, unit: .kilometersPerHour),
                gust: Measurement(value: windGustSpeedMax, unit: .kilometersPerHour)
            ),
            highWindSpeed: Measurement(value: windSpeedMax, unit: .kilometersPerHour)
        )
    }
}
