//
//  DayTemperatureStatistics.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// Temperature statistics for a specific day of the year.
@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
public struct DayTemperatureStatistics: Codable, Equatable, Sendable {
    /// The day of the year, in UTC.
    ///
    /// The day ranges from 1 to 366.
    public var day: Int

    /// The average observed low temperature for the day.
    public var averageLowTemperature: Measurement<UnitTemperature>

    /// The average observed high temperature for the day.
    public var averageHighTemperature: Measurement<UnitTemperature>

    public init(
        day: Int,
        averageLowTemperature: Measurement<UnitTemperature>,
        averageHighTemperature: Measurement<UnitTemperature>
    ) {
        self.day = day
        self.averageLowTemperature = averageLowTemperature
        self.averageHighTemperature = averageHighTemperature
    }
}
