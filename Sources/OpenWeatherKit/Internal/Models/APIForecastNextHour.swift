//
//  APIForecastNextHour.swift
//  
//
//  Created by Jeremy Greenwood on 10/16/22.
//

@preconcurrency import Foundation

// MARK: - APIForecastNextHour
struct APIForecastNextHour: Codable, Equatable {
    let name: String
    let metadata: APIMetadata
    let summary: [APIMinute]
    let forecastStart: Date
    let forecastEnd: Date
    let minutes: [APIMinute]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case metadata = "metadata"
        case summary = "summary"
        case forecastStart = "forecastStart"
        case forecastEnd = "forecastEnd"
        case minutes = "minutes"
    }
}

// MARK: - APIMinute
struct APIMinute: Codable, Equatable {
    let startTime: Date
    let precipitationChance: Double
    let precipitationIntensity: Double
    let condition: String?

    enum CodingKeys: String, CodingKey {
        case startTime = "startTime"
        case precipitationChance = "precipitationChance"
        case precipitationIntensity = "precipitationIntensity"
        case condition = "condition"
    }
}
