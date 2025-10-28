//
//  Forecast.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// A forecast collection for minute, hourly, and daily forecasts.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct Forecast<Element> : RandomAccessCollection, Codable, Equatable, Sendable where Element : Decodable, Element : Encodable, Element : Equatable, Element : Sendable {
    public init(forecast: [Element], metadata: WeatherMetadata) {
        self.forecast = forecast
        self.metadata = metadata
    }

    /// The forecast index.
    public typealias Index = Int

    /// The forecast collection.
    public var forecast: [Element]

    /// The forecast metadata.
    public var metadata: WeatherMetadata

    /// The forecast start index.
    public var startIndex: Forecast<Element>.Index { forecast.startIndex }

    /// The forecast end index.
    public var endIndex: Forecast<Element>.Index { forecast.endIndex }

    /// The forecast element at the provided index.
    public subscript(position: Forecast<Element>.Index) -> Element { forecast[position] }

    /// A type that represents the indices that are valid for subscripting the
    /// collection, in ascending order.
    public typealias Indices = Range<Forecast<Element>.Index>

    /// A type that provides the collection's iteration interface and
    /// encapsulates its iteration state.
    ///
    /// By default, a collection conforms to the `Sequence` protocol by
    /// supplying `IndexingIterator` as its associated `Iterator`
    /// type.
    public typealias Iterator = IndexingIterator<Forecast<Element>>

    /// A collection representing a contiguous subrange of this collection's
    /// elements. The subsequence shares indices with the original collection.
    ///
    /// The default subsequence type for collections that don't define their own
    /// is `Slice`.
    public typealias SubSequence = Slice<Forecast<Element>>
}
