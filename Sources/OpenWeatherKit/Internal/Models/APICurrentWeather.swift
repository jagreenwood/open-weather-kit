//
//  APICurrentWeather.swift
//  
//
//  Created by Jeremy Greenwood on 9/4/22.
//

@preconcurrency import Foundation

// MARK: - APICurrentWeather
struct APICurrentWeather: Codable, Equatable {
    let name: String
    let metadata: APIMetadata
    let asOf: Date
    let cloudCover: Double
    let conditionCode: String
    let daylight: Bool
    let humidity: Double
    let precipitationIntensity: Int
    let pressure: Double
    let pressureTrend: String
    let temperature: Double
    let temperatureApparent: Double
    let temperatureDewPoint: Double
    let uvIndex: Int
    let visibility: Double
    let windDirection: Double
    let windGust: Double
    let windSpeed: Double

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case metadata = "metadata"
        case asOf = "asOf"
        case cloudCover = "cloudCover"
        case conditionCode = "conditionCode"
        case daylight = "daylight"
        case humidity = "humidity"
        case precipitationIntensity = "precipitationIntensity"
        case pressure = "pressure"
        case pressureTrend = "pressureTrend"
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
