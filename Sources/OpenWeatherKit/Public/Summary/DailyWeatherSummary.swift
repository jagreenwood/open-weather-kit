//
//  DailyWeatherSummary.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

///
/// A structure that holds a collection of day weather summaries.
///
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct DailyWeatherSummary<T> : Codable, Equatable, Sendable, RandomAccessCollection where T : Decodable, T : Encodable, T : Equatable, T : Sendable {

    /// A type representing the sequence's elements.
    public typealias Element = T

    /// A type that represents a position in the collection.
    ///
    /// Valid indices consist of the position of every element and a
    /// "past the end" position that's not valid for use as a subscript
    /// argument.
    public typealias Index = Int

    /// An ordered collection of day weather summaries of type `T`, for each requested day.
    public var days: [T]

    /// Descriptive information about the weather statistics data.
    public var metadata: WeatherMetadata

    /// The start index for the daily weather summaries.
    public var startIndex: DailyWeatherSummary<T>.Index { days.startIndex }

    /// The end index for the daily weather summaries.
    public var endIndex: DailyWeatherSummary<T>.Index { days.endIndex }

    /// The day weather summary at the provided index.
    public subscript(position: DailyWeatherSummary<T>.Index) -> DailyWeatherSummary<T>.Element { days[position] }
}
