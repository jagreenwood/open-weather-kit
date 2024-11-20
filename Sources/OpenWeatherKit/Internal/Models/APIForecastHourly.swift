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
    let forecastStart: Date
    let cloudCover: Double
    let conditionCode: String
    let daylight: Bool
    let humidity: Double
    let precipitationAmount: Double
    let precipitationIntensity: Double
    let precipitationChance: Double
    let precipitationType: String
    let pressure: Double
    let pressureTrend: String
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
