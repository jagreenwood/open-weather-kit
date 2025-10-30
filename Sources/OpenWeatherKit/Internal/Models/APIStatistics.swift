//
//  APIStatistics.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

// MARK: - APIHourlyStatistics
@usableFromInline
struct APIHourlyStatistics: Codable, Sendable, Equatable {
    let metadata: APIMetadata
    let hours: [APIHourlyStatisticsData]
    let baselineStart: Int

    enum CodingKeys: String, CodingKey {
        case metadata
        case hours
        case baselineStart
    }
}

// MARK: - APIHourlyStatisticsData
@usableFromInline
struct APIHourlyStatisticsData: Codable, Sendable, Equatable {
    let hourOfYear: Int  // Hour of year (1-8784)
    let temperature: APITemperatureStatistics

    enum CodingKeys: String, CodingKey {
        case hourOfYear
        case temperature
    }
}

// MARK: - APIDailyStatistics
@usableFromInline
struct APIDailyStatistics: Codable, Sendable, Equatable {
    let metadata: APIMetadata
    let days: [APIDailyStatisticsData]
    let baselineStart: Int

    enum CodingKeys: String, CodingKey {
        case metadata
        case days
        case baselineStart
    }
}

// MARK: - APIDailyStatisticsData
@usableFromInline
struct APIDailyStatisticsData: Codable, Sendable, Equatable {
    let dayOfYear: Int  // Day of year (1-366)
    let temperature: APITemperatureStatistics?
    let precipitation: APIPrecipitationStatistics?

    enum CodingKeys: String, CodingKey {
        case dayOfYear
        case temperature
        case precipitation
    }
}

// MARK: - APIMonthlyStatistics
@usableFromInline
struct APIMonthlyStatistics: Codable, Sendable, Equatable {
    let metadata: APIMetadata
    let months: [APIMonthlyStatisticsData]
    let baselineStart: Int

    enum CodingKeys: String, CodingKey {
        case metadata
        case months
        case baselineStart
    }
}

// MARK: - APIMonthlyStatisticsData
@usableFromInline
struct APIMonthlyStatisticsData: Codable, Sendable, Equatable {
    let month: Int  // Month (1-12)
    let temperature: APITemperatureStatistics?
    let precipitation: APIPrecipitationStatistics?

    enum CodingKeys: String, CodingKey {
        case month
        case temperature
        case precipitation
    }
}

// MARK: - APITemperatureStatistics
@usableFromInline
struct APITemperatureStatistics: Codable, Sendable, Equatable {
    let min: Double?
    let max: Double?
    let p10: Double?  // 10th percentile
    let p50: Double?  // 50th percentile (median)
    let p90: Double?  // 90th percentile

    enum CodingKeys: String, CodingKey {
        case min
        case max
        case p10
        case p50
        case p90
    }
}

// MARK: - APIPrecipitationStatistics
@usableFromInline
struct APIPrecipitationStatistics: Codable, Sendable, Equatable {
    let probability: Int
    let averageAmount: Double
    let averageSnowfallAmount: Double

    enum CodingKeys: String, CodingKey {
        case probability
        case averageAmount
        case averageSnowfallAmount
    }
}
