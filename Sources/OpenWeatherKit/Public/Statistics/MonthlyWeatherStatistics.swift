//
//  MonthlyWeatherStatistics.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// A structure that contains monthly climatological statistics for a location.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct MonthlyWeatherStatistics<T>: Codable, Equatable, Sendable, RandomAccessCollection where T: Decodable, T: Encodable, T: Equatable, T: Sendable {

    /// A type representing the sequence's elements.
    public typealias Element = T

    /// A type that represents a position in the collection.
    ///
    /// Valid indices consist of the position of every element and a
    /// "past the end" position that's not valid for use as a subscript
    /// argument.
    public typealias Index = Int

    /// An ordered collection of month weather statistics data of type `T`, for each requested month.
    public var months: [T]

    /// The year the statistics collection began.
    public var baselineStartDate: Date

    /// Descriptive information about the weather statistics data.
    public var metadata: WeatherMetadata

    /// The start index for the monthly weather statistics.
    public var startIndex: MonthlyWeatherStatistics<T>.Index { months.startIndex }

    /// The end index for the monthly weather statistics.
    public var endIndex: MonthlyWeatherStatistics<T>.Index { months.endIndex }

    /// The month weather statistics at the provided index.
    public subscript(position: MonthlyWeatherStatistics<T>.Index) -> MonthlyWeatherStatistics<T>.Element { months[position] }
}
