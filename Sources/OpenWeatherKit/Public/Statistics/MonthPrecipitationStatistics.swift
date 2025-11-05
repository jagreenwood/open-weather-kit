//
//  MonthPrecipitationStatistics.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// Precipitation statistics for a specific month.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct MonthPrecipitationStatistics: Codable, Equatable, Sendable {
    /// The month of the year, in UTC.
    ///
    /// The Gregorian month of the year ranges from 1 (January) to 12 (December).
    public var month: Int

    /// The average percentage probability of precipitation (0.0 = 0%, 1.0 = 100%) for the month.
    public var averagePrecipitationProbability: Double

    /// The average amount of liquid precipitation for the month.
    public var averagePrecipitationAmount: Measurement<UnitLength>

    /// The average amount of snowfall as depth of snow crystals for the month.
    public var averageSnowfallAmount: Measurement<UnitLength>
}
