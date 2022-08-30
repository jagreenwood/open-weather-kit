//
//  UVIndex.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct UVIndex {

    /// The UV Index value.
    public var value: Int

    /// The UV Index exposure category.
    public var category: UVIndex.ExposureCategory

    ///
    /// An enumeration that indicates risk of harm from unprotected sun exposure.
    ///
    @frozen public enum ExposureCategory : String, Codable, Comparable, CustomStringConvertible, CaseIterable {

        /// The UV index is low.
        ///
        /// The valid values of this property are 0, 1, and 2.
        case low

        /// The UV index is moderate.
        ///
        /// The valid values of this property are 3, 4, and 5.
        case moderate

        /// The UV index is high.
        ///
        /// The valid values of this property are 6 and 7.
        case high

        /// The UV index is very high.
        ///
        /// The valid values of this property are 8, 9, and 10.
        case veryHigh

        /// The UV index is extreme.
        ///
        /// The valid values of this property are 11 and higher.
        case extreme

        /// The range of UV index values that falls into this category.
        public var rangeValue: ClosedRange<Int> {
            fatalError("not implemented")
        }

        /// The localized string describing the risk of harm from unprotected sun exposure.
        public var description: String {
            fatalError("not implemented")
        }

        /// A localized accessibility description describing the UV Index Exposure Category,
        /// suitable for Voice Over and other assistive technologies.
        public var accessibilityDescription: String {
            fatalError("not implemented")
        }

        /// Returns a Boolean value indicating whether the value of the first
        /// argument is less than that of the second argument.
        ///
        /// This function is the only requirement of the `Comparable` protocol. The
        /// remainder of the relational operator functions are implemented by the
        /// standard library for any type that conforms to `Comparable`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func < (lhs: UVIndex.ExposureCategory, rhs: UVIndex.ExposureCategory) -> Bool {
            fatalError("not implemented")
        }

        /// Creates a new instance with the specified raw value.
        ///
        /// If there is no value of the type that corresponds with the specified raw
        /// value, this initializer returns `nil`. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     print(PaperSize(rawValue: "Legal"))
        ///     // Prints "Optional("PaperSize.Legal")"
        ///
        ///     print(PaperSize(rawValue: "Tabloid"))
        ///     // Prints "nil"
        ///
        /// - Parameter rawValue: The raw value to use for the new instance.
        public init?(rawValue: String) {
            fatalError("not implemented")
        }

        /// A type that can represent a collection of all values of this type.
        public typealias AllCases = [UVIndex.ExposureCategory]

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        public typealias RawValue = String

        /// A collection of all values of this type.
        public static var allCases: [UVIndex.ExposureCategory] {
            fatalError("not implemented")
        }

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public var rawValue: String {
            fatalError("not implemented")
        }
    }
}

extension UVIndex: Codable {}
extension UVIndex: Equatable {}
