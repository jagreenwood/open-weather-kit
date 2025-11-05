//
//  DayPrecipitationStatistics.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// Precipitation statistics for a specific day of the year.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct DayPrecipitationStatistics: Codable, Equatable, Sendable {
    /// The day of the year, in UTC.
    ///
    /// The day ranges from 1 to 366.
    public var day: Int

    /// The average percentage probability of precipitation (0.0 = 0%, 1.0 = 100%) for the day.
    public var averagePrecipitationProbability: Double

    /// The average amount of liquid precipitation for the day.
    public var averagePrecipitationAmount: Measurement<UnitLength>

    /// The average amount of snowfall as depth of snow crystals for the day.
    public var averageSnowfallAmount: Measurement<UnitLength>
}
