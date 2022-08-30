//
//  Forecast.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct Forecast<Element> : RandomAccessCollection, Codable, Equatable where Element : Decodable, Element : Encodable, Element : Equatable {

    /// The forecast index.
    public typealias Index = Int

    /// The forecast collection.
    public var forecast: [Element]

    /// The forecast metadata.
    public var metadata: WeatherMetadata

    /// The forecast start index.
    public var startIndex: Forecast<Element>.Index {
        fatalError("not implemented")
    }

    /// The forecast end index.
    public var endIndex: Forecast<Element>.Index {
        fatalError("not implemented")
    }

    /// The forecast element at the provided index.
    public subscript(position: Forecast<Element>.Index) -> Element {
        fatalError("not implemented")
    }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Forecast<Element>, b: Forecast<Element>) -> Bool {
        fatalError("not implemented")
    }

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

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        fatalError("not implemented")
    }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        fatalError("not implemented")
    }
}
