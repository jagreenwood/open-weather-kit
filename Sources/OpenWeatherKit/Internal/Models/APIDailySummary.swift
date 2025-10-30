//
//  APIDailySummary.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

// MARK: - APIDailySummary
@usableFromInline
struct APIDailySummary: Codable, Sendable, Equatable {
    let metadata: APIMetadata
    let days: [APIDailySummaryDay]
    let startDate: Int  // Days from epoch
    let endDate: Int    // Days from epoch

    enum CodingKeys: String, CodingKey {
        case metadata
        case days
        case startDate
        case endDate
    }
}

// MARK: - APIDailySummaryDay
@usableFromInline
struct APIDailySummaryDay: Codable, Sendable, Equatable {
    let date: Int  // Days from epoch (e.g., days since 1970-01-01)
    let temperatureMin: Double
    let temperatureMax: Double
    let precipitationAmount: Double
    let snowfallAmount: Double

    enum CodingKeys: String, CodingKey {
        case date
        case temperatureMin
        case temperatureMax
        case precipitationAmount
        case snowfallAmount
    }
}
