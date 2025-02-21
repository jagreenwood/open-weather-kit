//
//  PrecipitationAmountByType.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 2/20/25.
//

import Foundation

///
/// A structure that provides a breakdown of amounts of all forms of precipitation that is expected to occur over a period of time.
///
public struct PrecipitationAmountByType: Sendable {

    /// The amount of hail for the period.
    public var hail: Measurement<UnitLength>

    /// The amount of wintry mix for the period.
    public var mixed: Measurement<UnitLength>

    /// The amount of rainfall for the period.
    public var rainfall: Measurement<UnitLength>

    /// The amount of sleet for the period.
    public var sleet: Measurement<UnitLength>

    /// The amount of liquid equivalent of all precipitation for the period.
    public var precipitation: Measurement<UnitLength>

    /// Describes the amount of snowfall for the period.
    public var snowfallAmount: SnowfallAmount
}

extension PrecipitationAmountByType: Codable {}
extension PrecipitationAmountByType: Equatable {}
