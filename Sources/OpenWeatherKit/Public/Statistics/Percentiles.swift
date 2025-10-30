//
//  Percentiles.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

///
/// A structure that describes probability distributions for a measurable weather condition.
///
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct Percentiles<Dimension> : Codable, Equatable, Sendable where Dimension : Unit {

    /// 10% of the distribution is less than this value.
    public var p10: Measurement<Dimension>

    /// 50% of the distribution is less than this value.
    public var p50: Measurement<Dimension>

    /// 90% of the distribution is less than this value.
    public var p90: Measurement<Dimension>
}
