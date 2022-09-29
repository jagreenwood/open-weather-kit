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
            switch self {
            case .low: return 0...2
            case .moderate: return 3...5
            case .high: return 6...7
            case .veryHigh: return 8...10
            case .extreme: return 11...20
            }
        }

        /// The localized string describing the risk of harm from unprotected sun exposure.
        public var description: String {
            switch self {
            case .low:
                return NSLocalizedString("UVIndex.low", bundle: BundleLocator.bundle, comment: "Low")
            case .moderate:
                return NSLocalizedString("UVIndex.moderate", bundle: BundleLocator.bundle, comment: "Moderate")
            case .high:
                return NSLocalizedString("UVIndex.high", bundle: BundleLocator.bundle, comment: "High")
            case .veryHigh:
                return NSLocalizedString("UVIndex.veryHigh", bundle: BundleLocator.bundle, comment: "Very High")
            case .extreme:
                return NSLocalizedString("UVIndex.extreme", bundle: BundleLocator.bundle, comment: "Extreme")
            }
        }

        /// A localized accessibility description describing the UV Index Exposure Category,
        /// suitable for Voice Over and other assistive technologies.
        public var accessibilityDescription: String {
            switch self {
            case .low:
                return NSLocalizedString("UVIndex.accessibility.low", bundle: BundleLocator.bundle, comment: "Low")
            case .moderate:
                return NSLocalizedString("UVIndex.accessibility.moderate", bundle: BundleLocator.bundle, comment: "Moderate")
            case .high:
                return NSLocalizedString("UVIndex.accessibility.high", bundle: BundleLocator.bundle, comment: "High")
            case .veryHigh:
                return NSLocalizedString("UVIndex.accessibility.veryHigh", bundle: BundleLocator.bundle, comment: "Very High")
            case .extreme:
                return NSLocalizedString("UVIndex.accessibility.extreme", bundle: BundleLocator.bundle, comment: "Extreme")
            }
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
            lhs.rangeValue.lowerBound < rhs.rangeValue.lowerBound
        }

        init(value: Int) {
            switch value {
            case 0...2: self = .low
            case 3...5: self = .moderate
            case 6...7: self = .high
            case 8...10: self = .veryHigh
            default: self = .extreme
            }
        }
    }
}

extension UVIndex: Codable {}
extension UVIndex: Equatable {}
