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
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct DayPrecipitationSummary : Codable, Equatable, Sendable {
    
    /// The day of the observed precipitation summary
    public var date: Date
    
    /// The amount of liquid precipitation for the day.
    public var precipitationAmount: Measurement<UnitLength>
    
    /// The snowfall amount as depth of snow crystals for the day.
    public var snowfallAmount: Measurement<UnitLength>
}
