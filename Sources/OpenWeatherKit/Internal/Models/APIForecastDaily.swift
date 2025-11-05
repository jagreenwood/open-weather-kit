//
//  APIForecastDaily.swift
//  
//
//  Created by Jeremy Greenwood on 10/16/22.
//

import Foundation

// MARK: - APIForecastDaily
struct APIForecastDaily: Codable, Equatable {
    let metadata: APIMetadata
    let days: [APIDay]

    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case days = "days"
    }
}

// MARK: - APIDay
struct APIDay: Codable, Equatable {
    @TextCaseCoding<Lowercased> var conditionCode: String
    @TextCaseCoding<Lowercased> var moonPhase: String
    @TextCaseCoding<Lowercased> var precipitationType: String
    let daytimeForecast: APIForecast
    let forecastEnd: Date
    let forecastStart: Date
    let humidityMax: Int
    let humidityMin: Int
    let maxUvIndex: Int
    let moonrise: Date?
    let moonset: Date?
    let overnightForecast: APIForecast
    let precipitationAmount: Double
    let precipitationAmountByType: [APIPrecipitationAmountByType]
    let precipitationChance: Int
    let restOfDayForecast: APIForecast?
    let snowfallAmount: Int
    let solarMidnight: Date?
    let solarNoon: Date?
    let sunrise: Date?
    let sunriseAstronomical: Date?
    let sunriseCivil: Date?
    let sunriseNautical: Date?
    let sunset: Date?
    let sunsetAstronomical: Date?
    let sunsetCivil: Date?
    let sunsetNautical: Date?
    let temperatureMax: Double
    let temperatureMaxTime: Date?
    let temperatureMin: Double
    let temperatureMinTime: Date?
    let visibilityMax: Double
    let visibilityMin: Double
    let windGustSpeedMax: Double
    let windSpeedAvg: Double
    let windSpeedMax: Double

    enum CodingKeys: String, CodingKey {
        case conditionCode = "conditionCode"
        case daytimeForecast = "daytimeForecast"
        case forecastEnd = "forecastEnd"
        case forecastStart = "forecastStart"
        case humidityMax = "humidityMax"
        case humidityMin = "humidityMin"
        case maxUvIndex = "maxUvIndex"
        case moonPhase = "moonPhase"
        case moonrise = "moonrise"
        case moonset = "moonset"
        case overnightForecast = "overnightForecast"
        case precipitationAmount = "precipitationAmount"
        case precipitationAmountByType = "precipitationAmountByType"
        case precipitationChance = "precipitationChance"
        case precipitationType = "precipitationType"
        case restOfDayForecast = "restOfDayForecast"
        case snowfallAmount = "snowfallAmount"
        case solarMidnight = "solarMidnight"
        case solarNoon = "solarNoon"
        case sunrise = "sunrise"
        case sunriseAstronomical = "sunriseAstronomical"
        case sunriseCivil = "sunriseCivil"
        case sunriseNautical = "sunriseNautical"
        case sunset = "sunset"
        case sunsetAstronomical = "sunsetAstronomical"
        case sunsetCivil = "sunsetCivil"
        case sunsetNautical = "sunsetNautical"
        case temperatureMax = "temperatureMax"
        case temperatureMaxTime = "temperatureMaxTime"
        case temperatureMin = "temperatureMin"
        case temperatureMinTime = "temperatureMinTime"
        case visibilityMax = "visibilityMax"
        case visibilityMin = "visibilityMin"
        case windGustSpeedMax = "windGustSpeedMax"
        case windSpeedAvg = "windSpeedAvg"
        case windSpeedMax = "windSpeedMax"
    }
}

// MARK: - APIForecast
struct APIForecast: Codable, Equatable {
    let cloudCover: Int
    let cloudCoverHighAltPct: Int
    let cloudCoverLowAltPct: Int
    let cloudCoverMidAltPct: Int
    let conditionCode: String
    let daylight: Bool
    let forecastEnd: Int
    let forecastStart: Int
    let humidity: Int
    let humidityMax: Int
    let humidityMin: Int
    let perceivedPrecipitationIntensityMax: Double
    let precipitationAmount: Double
    let precipitationAmountByType: [APIPrecipitationAmountByType]
    let precipitationChance: Int
    let precipitationIntensityMax: Double
    let precipitationType: String
    let snowfallAmount: Int
    let temperatureApparentMax: Double
    let temperatureApparentMin: Double
    let temperatureMax: Double
    let temperatureMin: Double
    let uvIndexMax: Int
    let uvIndexMin: Int
    let visibilityMax: Double
    let visibilityMin: Double
    let windDirection: Int
    let windGustSpeedMax: Double
    let windSpeed: Double
    let windSpeedMax: Double

    enum CodingKeys: String, CodingKey {
        case cloudCover = "cloudCover"
        case cloudCoverHighAltPct = "cloudCoverHighAltPct"
        case cloudCoverLowAltPct = "cloudCoverLowAltPct"
        case cloudCoverMidAltPct = "cloudCoverMidAltPct"
        case conditionCode = "conditionCode"
        case daylight = "daylight"
        case forecastEnd = "forecastEnd"
        case forecastStart = "forecastStart"
        case humidity = "humidity"
        case humidityMax = "humidityMax"
        case humidityMin = "humidityMin"
        case perceivedPrecipitationIntensityMax = "perceivedPrecipitationIntensityMax"
        case precipitationAmount = "precipitationAmount"
        case precipitationAmountByType = "precipitationAmountByType"
        case precipitationChance = "precipitationChance"
        case precipitationIntensityMax = "precipitationIntensityMax"
        case precipitationType = "precipitationType"
        case snowfallAmount = "snowfallAmount"
        case temperatureApparentMax = "temperatureApparentMax"
        case temperatureApparentMin = "temperatureApparentMin"
        case temperatureMax = "temperatureMax"
        case temperatureMin = "temperatureMin"
        case uvIndexMax = "uvIndexMax"
        case uvIndexMin = "uvIndexMin"
        case visibilityMax = "visibilityMax"
        case visibilityMin = "visibilityMin"
        case windDirection = "windDirection"
        case windGustSpeedMax = "windGustSpeedMax"
        case windSpeed = "windSpeed"
        case windSpeedMax = "windSpeedMax"
    }
}
