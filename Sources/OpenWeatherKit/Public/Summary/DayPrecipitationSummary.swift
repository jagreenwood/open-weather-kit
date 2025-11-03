//
//  DayPrecipitationSummary.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/30/25.
//

import Foundation

///
/// A structure that describes the precipitation summary for a day.
///
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct DayPrecipitationSummary : Codable, Equatable, Sendable {
    
    /// The day of the observed precipitation summary
    public var date: Date
    
    /// The amount of liquid precipitation for the day.
    public var precipitationAmount: Measurement<UnitLength>
    
    /// The snowfall amount as depth of snow crystals for the day.
    public var snowfallAmount: Measurement<UnitLength>
}
