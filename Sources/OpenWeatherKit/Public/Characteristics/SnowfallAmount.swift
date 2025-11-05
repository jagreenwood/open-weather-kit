//
//  SnowfallAmount.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 2/20/25.
//

import Foundation

///
/// A structure that describes the snowfall amount over a period of time.
///
public struct SnowfallAmount: Sendable {

    /// The estimated amount of snowfall as depth of snow crystals for the period.
    public var amount: Measurement<UnitLength>

    /// The maximum amount of snowfall as depth of snow crystals for the period.
    public var maximum: Measurement<UnitLength>

    /// The minimum amount of snowfall as depth of snow crystals for the period.
    public var minimum: Measurement<UnitLength>

    /// The estimated amount of snowfall as liquid equivalent for the period.
    public var amountLiquidEquivalent: Measurement<UnitLength>

    /// The maximum amount of snowfall as liquid equivalent for the period.
    public var maximumLiquidEquivalent: Measurement<UnitLength>

    /// The minimum amount of snowfall as liquid equivalent for the period.
    public var minimumLiquidEquivalent: Measurement<UnitLength>
}

extension SnowfallAmount: Codable {}
extension SnowfallAmount: Equatable {}
