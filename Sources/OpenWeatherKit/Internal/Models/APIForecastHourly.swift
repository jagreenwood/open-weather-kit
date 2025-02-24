//
//  APIForecastHourly.swift
//  
//
//  Created by Jeremy Greenwood on 10/16/22.
//

import Foundation

// MARK: - APIForecastHourly
struct APIForecastHourly: Codable, Equatable {
    let name: String
    let metadata: APIMetadata
    let hours: [APIHour]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case metadata = "metadata"
        case hours = "hours"
    }
}

// MARK: - APIHour
struct APIHour: Codable, Equatable {
    @TextCaseCoding<Lowercased> var conditionCode: String
    @TextCaseCoding<Lowercased> var precipitationType: String
    @TextCaseCoding<Lowercased> var pressureTrend: String
    let cloudCover: Double
    let daylight: Bool
    let forecastStart: Date
    let humidity: Double
    let precipitationAmount: Double
    let precipitationChance: Double
    let precipitationIntensity: Double
    let pressure: Double
    let snowfallAmount: Double?
    let snowfallIntensity: Double?
    let temperature: Double
    let temperatureApparent: Double
    let temperatureDewPoint: Double
    let uvIndex: Int
    let visibility: Double
    let windDirection: Double
    let windGust: Double
    let windSpeed: Double

    enum CodingKeys: String, CodingKey {
        case forecastStart = "forecastStart"
        case cloudCover = "cloudCover"
        case conditionCode = "conditionCode"
        case daylight = "daylight"
        case humidity = "humidity"
        case precipitationAmount = "precipitationAmount"
        case precipitationIntensity = "precipitationIntensity"
        case precipitationChance = "precipitationChance"
        case precipitationType = "precipitationType"
        case pressure = "pressure"
        case pressureTrend = "pressureTrend"
        case snowfallIntensity = "snowfallIntensity"
        case snowfallAmount = "snowfallAmount"
        case temperature = "temperature"
        case temperatureApparent = "temperatureApparent"
        case temperatureDewPoint = "temperatureDewPoint"
        case uvIndex = "uvIndex"
        case visibility = "visibility"
        case windDirection = "windDirection"
        case windGust = "windGust"
        case windSpeed = "windSpeed"
    }
}
