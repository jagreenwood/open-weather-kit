//
//  CloudCoverByAltitude.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 2/20/25.
//

import Foundation

///
/// Contains the percentage of sky covered by low, medium and high altitude cloud.
///
public struct CloudCoverByAltitude: Sendable {

    /// The percentage of the sky covered with low-altitude clouds.
    /// Low-level Cloud Cover (LCC) corresponds to levels between 0m and 1800m above the model's earth surface.
    ///
    /// The value is from `0` (no cloud cover)  to `1` (complete cloud cover).
    public var low: Double

    /// The percentage of the sky covered with mid-altitude clouds.
    /// Medium-level Cloud Cover (MCC) corresponds to levels between 1800m and 6300m above the model's earth surface.
    ///
    /// The value is from `0` (no cloud cover)  to `1` (complete cloud cover).
    public var medium: Double

    /// The percentage of the sky covered with high-altitude clouds.
    /// High-level Cloud Cover (HCC)corresponds to levels higher than 6300m above the model's earth surface.
    ///
    /// The value is from `0` (no cloud cover)  to `1` (complete cloud cover).
    public var high: Double
}

extension CloudCoverByAltitude: Codable {}
extension CloudCoverByAltitude: Equatable {}
