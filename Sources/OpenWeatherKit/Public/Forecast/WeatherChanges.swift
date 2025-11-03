//
//  WeatherChanges.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/31/25.
//

import Foundation

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct WeatherChanges: RandomAccessCollection, Sendable, Codable, Equatable {

    /// A type representing the sequence's elements.
    public typealias Element = WeatherChange

    /// A type that represents a position in the collection.
    ///
    /// Valid indices consist of the position of every element and a
    /// "past the end" position that's not valid for use as a subscript
    /// argument.
    public typealias Index = Int

    /// A list of forecasted weather changes, in chronological order.
    public var changes: [WeatherChange]

    /// Descriptive information about the weather change data.
    public var metadata: WeatherMetadata

    /// The start index for the weather changes.
    public var startIndex: WeatherChanges.Index { changes.startIndex }

    /// The end index for the weather changes.
    public var endIndex: WeatherChanges.Index { changes.endIndex }

    /// The weather change at the provided index.
    public subscript(position: WeatherChanges.Index) -> WeatherChanges.Element { changes[position] }
}

///
/// A structure that informs how certain measurable weather aspects are expected to change relative to before.
///
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct WeatherChange: Sendable, Codable, Equatable {

    ///
    /// An enum that specifies the direction in which a measurable aspect of the weather is expected to change.
    ///
    @frozen public enum Direction: String, Codable, Sendable, Equatable {

        /// The value will be significantly higher than before.
        case increase

        /// The value will be significantly lower than before.
        case decrease

        /// The value will remain similar to before.
        case steady
    }

    /// The date at which this change record becomes effective.
    public var date: Date

    /// How the high temperature for this day compares to that of before.
    public var highTemperature: WeatherChange.Direction

    /// How the low temperature for this day compares to that of before.
    public var lowTemperature: WeatherChange.Direction

    /// How the forecasted precipitation amount for this day, during daylight hours, compares to that of before.
    public var dayPrecipitationAmount: WeatherChange.Direction

    /// How the forecasted precipitation amount, during the night of this day, compares to that of before.
    public var nightPrecipitationAmount: WeatherChange.Direction
}
