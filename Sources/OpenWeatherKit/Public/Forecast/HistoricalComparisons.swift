//
//  HistoricalComparisons.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/31/25.
//

import Foundation

///
/// A structure that represents the weather condition comparisons for a specific location.
/// It's a list of comparisons between current readings and historical averages.
/// The list is ordered by significance of deviation.
///
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct HistoricalComparisons: Codable, Equatable, Sendable, RandomAccessCollection {

    /// A type representing the sequence's elements.
    public typealias Element = HistoricalComparison

    /// A type that represents a position in the collection.
    ///
    /// Valid indices consist of the position of every element and a
    /// "past the end" position that's not valid for use as a subscript
    /// argument.
    public typealias Index = Int

    /// A list of comparisons between current readings and historical averages, ordered by significance of deviation.
    public var comparisons: [HistoricalComparison]

    /// Descriptive information about the weather comparisons data.
    public var metadata: WeatherMetadata

    /// The start index for the historical comparisons.
    public var startIndex: HistoricalComparisons.Index { comparisons.startIndex }

    /// The end index for the historical comparisons.
    public var endIndex: HistoricalComparisons.Index { comparisons.endIndex }

    /// The historical comparison at the provided index.
    public subscript(position: HistoricalComparisons.Index) -> HistoricalComparisons.Element { comparisons[position] }
}

///
/// An enum that represents a recognized comparison in the statistical analysis of a location's historical weather data.
///
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public enum HistoricalComparison: Codable, Equatable, Sendable {

    /// The comparison relates to the location's maximum temperature averaged since ~1970.
    case highTemperature(Trend<UnitTemperature>)

    /// The comparison relates to the location's minimum temperature averaged since ~1970.
    case lowTemperature(Trend<UnitTemperature>)

    /// The comparison relates to the amount of precipitation at the location averaged over the past 30 days.
    case precipitationAmount(Trend<UnitLength>)

    /// The comparison relates to the amount of snowfall at the location averaged over the past 30 days.
    case snowfallAmount(Trend<UnitLength>)
}

///
/// A structure describing an observed pattern in the data for weather at a location for a specific condition.
///
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct Trend<Dimension>: Codable, Sendable, Equatable where Dimension: Unit {

    /// The manner in which the comparison between the baseline and current values are compared.
    public var baseline: TrendBaseline<Dimension>

    /// The current recorded value for the condition in which the trend is compared against.
    public var currentValue: Measurement<Dimension>

    /// Semantically describes the manner in which the observed trend compares the current value against the baseline value.
    public var deviation: Deviation
}

///
/// A type encapsulating everything there is to know about what a trend baseline is.
///
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct TrendBaseline<Dimension> : Codable, Sendable, Equatable where Dimension: Unit {

    /// An enum describing what value is being compared between historical and current readings.
    public enum Kind: String, Codable, Equatable, Sendable, Hashable {

        /// The baseline value is a mean (or average) of other values.
        case mean
    }

    /// The manner in which the comparison between the baseline and current values are compared.
    public let kind: TrendBaseline<Dimension>.Kind

    /// The recorded baseline value for the condition in which the trend is comparing to.
    public let value: Measurement<Dimension>

    /// The year the statistics collection began.
    public let startDate: Date
}

///
/// Describes a comparison between two values in a trend.
///
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public enum Deviation: String, Codable, Equatable, Sendable, Hashable {

    /// The most recently observed value is much larger than the value it is being compared against.
    case muchHigher = "much_higher"

    /// The most recently observed value is larger than the value it is being compared against.
    case higher

    /// The most recently observed value is about the same as the value it is being compared against.
    case normal

    /// The most recently observed value is lower than the value it is being compared against.
    case lower

    /// The most recently observed value is much lower than the value it is being compared against.
    case muchLower = "much_lower"
}
