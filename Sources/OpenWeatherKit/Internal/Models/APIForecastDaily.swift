//
//  APIForecastDaily.swift
//  
//
//  Created by Jeremy Greenwood on 10/16/22.
//

import Foundation

// MARK: - APIForecastDaily
struct APIForecastDaily: Codable, Equatable {
    let name: String
    let metadata: APIMetadata
    let days: [APIDay]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case metadata = "metadata"
        case days = "days"
    }
}

// MARK: - APIDay
struct APIDay: Codable, Equatable {
    let forecastStart: Date
    let forecastEnd: Date
    let conditionCode: String
    let maxUvIndex: Int
    let moonPhase: String
    let moonrise: Date?
    let moonset: Date
    let precipitationAmount: Double
    let precipitationChance: Double
    let precipitationType: String
    let snowfallAmount: Int
    let solarMidnight: Date
    let solarNoon: Date
    let sunrise: Date
    let sunriseCivil: Date
    let sunriseNautical: Date
    let sunriseAstronomical: Date
    let sunset: Date
    let sunsetCivil: Date
    let sunsetNautical: Date
    let sunsetAstronomical: Date
    let temperatureMax: Double
    let temperatureMin: Double
    let daytimeForecast: APIForecast
    let overnightForecast: APIForecast
    let restOfDayForecast: APIForecast?

    enum CodingKeys: String, CodingKey {
        case forecastStart = "forecastStart"
        case forecastEnd = "forecastEnd"
        case conditionCode = "conditionCode"
        case maxUvIndex = "maxUvIndex"
        case moonPhase = "moonPhase"
        case moonrise = "moonrise"
        case moonset = "moonset"
        case precipitationAmount = "precipitationAmount"
        case precipitationChance = "precipitationChance"
        case precipitationType = "precipitationType"
        case snowfallAmount = "snowfallAmount"
        case solarMidnight = "solarMidnight"
        case solarNoon = "solarNoon"
        case sunrise = "sunrise"
        case sunriseCivil = "sunriseCivil"
        case sunriseNautical = "sunriseNautical"
        case sunriseAstronomical = "sunriseAstronomical"
        case sunset = "sunset"
        case sunsetCivil = "sunsetCivil"
        case sunsetNautical = "sunsetNautical"
        case sunsetAstronomical = "sunsetAstronomical"
        case temperatureMax = "temperatureMax"
        case temperatureMin = "temperatureMin"
        case daytimeForecast = "daytimeForecast"
        case overnightForecast = "overnightForecast"
        case restOfDayForecast = "restOfDayForecast"
    }
}

// MARK: - APIForecast
struct APIForecast: Codable, Equatable {
    let forecastStart: Date
    let forecastEnd: Date
    let cloudCover: Double
    let conditionCode: String
    let humidity: Double
    let precipitationAmount: Double
    let precipitationChance: Double
    let precipitationType: String
    let snowfallAmount: Int
    let windDirection: Int
    let windSpeed: Double

    enum CodingKeys: String, CodingKey {
        case forecastStart = "forecastStart"
        case forecastEnd = "forecastEnd"
        case cloudCover = "cloudCover"
        case conditionCode = "conditionCode"
        case humidity = "humidity"
        case precipitationAmount = "precipitationAmount"
        case precipitationChance = "precipitationChance"
        case precipitationType = "precipitationType"
        case snowfallAmount = "snowfallAmount"
        case windDirection = "windDirection"
        case windSpeed = "windSpeed"
    }
}
