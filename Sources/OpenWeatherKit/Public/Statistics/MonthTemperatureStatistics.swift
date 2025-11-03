//
//  MonthTemperatureStatistics.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// Temperature statistics for a specific month.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct MonthTemperatureStatistics: Codable, Equatable, Sendable {

    /// The month of the year, in UTC.
    ///
    /// The Gregorian month of the year ranges from 1 (January) to 12 (December).
    public var month: Int

    /// The average observed low temperature for the month.
    public var averageLowTemperature: Measurement<UnitTemperature>

    /// The average observed high temperature for the month.
    public var averageHighTemperature: Measurement<UnitTemperature>
}
