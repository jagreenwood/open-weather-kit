//
//  APIForecastNextHour.swift
//
//
//  Created by Jeremy Greenwood on 10/16/22.
//

import Foundation

// MARK: - APIForecastNextHour
struct APIForecastNextHour: Codable, Equatable {
    let condition: [APICondition]
    let forecastEnd: Date
    let forecastStart: Date
    let metadata: APIMetadata
    let minutes: [APIMinute]
    let summary: [APIMinute]

    enum CodingKeys: String, CodingKey {
        case condition = "condition"
        case forecastEnd = "forecastEnd"
        case forecastStart = "forecastStart"
        case metadata = "metadata"
        case minutes = "minutes"
        case summary = "summary"
    }
}

// MARK: - APIMinute
struct APIMinute: Codable, Equatable {
    let precipitationChance: Double
    let precipitationIntensity: Double
    let startTime: Date

    enum CodingKeys: String, CodingKey {
        case precipitationChance = "precipitationChance"
        case precipitationIntensity = "precipitationIntensity"
        case startTime = "startTime"
    }
}

// MARK: - APICondition
struct APICondition: Codable, Equatable {
    @TextCaseCoding<Lowercased> var beginCondition: String
    @TextCaseCoding<Lowercased> var endCondition: String
    @TextCaseCoding<Lowercased> var forecastToken: String
    let startTime: Date
}
