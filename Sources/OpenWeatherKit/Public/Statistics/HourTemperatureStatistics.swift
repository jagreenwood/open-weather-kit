//
//  HourTemperatureStatistics.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// Temperature statistics for a specific hour of the year.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct HourTemperatureStatistics: Codable, Equatable, Sendable {
    /// The hour of the year, in UTC.
    ///
    /// The hour ranges from 1 to 8784.
    public var hour: Int

    /// The temperature statistics for the hour.
    public var percentiles: Percentiles<UnitTemperature>
}
