//
//  APIHistoricalComparisons.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/31/25.
//

import Foundation

// MARK: - APIHistoricalComparisons
struct APIHistoricalComparisons: Codable, Equatable, Sendable {
    let metadata: APIMetadata
    let comparisons: [APIComparison]

    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case comparisons = "comparisons"
    }
}

// MARK: - APIComparison
struct APIComparison: Codable, Equatable, Sendable {
    @TextCaseCoding<Lowercased> var baselineType: String
    @TextCaseCoding<Lowercased> var condition: String
    @TextCaseCoding<Lowercased> var deviation: String
    let baselineStartDate: Date
    let baselineValue: Double
    let currentValue: Double

    var conditionType: Condition {
        guard let condition = Condition(rawValue: condition) else {
            assertionFailure("Could not parse comparison condition \(condition)")
            return .unknown
        }

        return condition
    }

    enum CodingKeys: String, CodingKey {
        case baselineStartDate = "baselineStartDate"
        case baselineType = "baselineType"
        case baselineValue = "baselineValue"
        case condition = "condition"
        case currentValue = "currentValue"
        case deviation = "deviation"
    }

    enum Condition: String {
        case temperatureMax = "temperature_max"
        case temperatureMin = "temperature_min"
        case precipitation = "precipitation"
        case snowfall = "snowfall"
        case unknown
    }
}
