//
//  DayTemperatureSummary.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/30/25.
//

import Foundation

///
/// A structure that describes the temperature summary for a day.
///
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct DayTemperatureSummary : Codable, Equatable, Sendable {
    
    /// The day of the observed temperature summary.
    public var date: Date
    
    /// The observed low temperature for the day.
    public var lowTemperature: Measurement<UnitTemperature>
    
    /// The observed high temperature for the day.
    public var highTemperature: Measurement<UnitTemperature>
}
