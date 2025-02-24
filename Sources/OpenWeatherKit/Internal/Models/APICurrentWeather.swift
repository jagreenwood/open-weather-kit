//
//  APICurrentWeather.swift
//  
//
//  Created by Jeremy Greenwood on 9/4/22.
//

import Foundation

// MARK: - APICurrentWeather
struct APICurrentWeather: Codable, Equatable {
    @TextCaseCoding<Lowercased> var conditionCode: String
    @TextCaseCoding<Lowercased> var pressureTrend: String
    let asOf: Date
    let cloudCover: Double
    let daylight: Bool
    let humidity: Double
    let metadata: APIMetadata
    let name: String
    let precipitationIntensity: Double
    let pressure: Double
    let temperature: Double
    let temperatureApparent: Double
    let temperatureDewPoint: Double
    let uvIndex: Int
    let visibility: Double
    let windDirection: Double
    let windGust: Double
    let windSpeed: Double

    enum CodingKeys: String, CodingKey {
        case asOf = "asOf"
        case cloudCover = "cloudCover"
        case conditionCode = "conditionCode"
        case daylight = "daylight"
        case humidity = "humidity"
        case metadata = "metadata"
        case name = "name"
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
