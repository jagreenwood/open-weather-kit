//
//  APIWeatherChanges.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/31/25.
//

import Foundation

// MARK: - APIWeatherChanges
struct APIWeatherChanges: Codable, Equatable, Sendable {
    let metadata: APIMetadata
    let changes: [APIChange]
    let forecastEnd: Date
    let forecastStart: Date

    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case changes = "changes"
        case forecastEnd = "forecastEnd"
        case forecastStart = "forecastStart"
    }
}

// MARK: - APIChange
struct APIChange: Codable, Equatable, Sendable {
    @TextCaseCoding<Lowercased> var dayPrecipitationChange: String
    @TextCaseCoding<Lowercased> var maxTemperatureChange: String
    @TextCaseCoding<Lowercased> var minTemperatureChange: String
    @TextCaseCoding<Lowercased> var nightPrecipitationChange: String
    let forecastEnd: Date
    let forecastStart: Date

    enum CodingKeys: String, CodingKey {
        case dayPrecipitationChange = "dayPrecipitationChange"
        case forecastEnd = "forecastEnd"
        case forecastStart = "forecastStart"
        case maxTemperatureChange = "maxTemperatureChange"
        case minTemperatureChange = "minTemperatureChange"
        case nightPrecipitationChange = "nightPrecipitationChange"
    }
}
