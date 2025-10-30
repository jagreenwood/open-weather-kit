//
//  HourTemperatureStatistics.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// Temperature statistics for a specific hour of the year.
@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
public struct HourTemperatureStatistics: Codable, Equatable, Sendable {
    /// The hour of the year, in UTC.
    ///
    /// The hour ranges from 1 to 8784.
    public var hour: Int

    /// The temperature statistics for the hour.
    public var percentiles: Percentiles<UnitTemperature>
}
