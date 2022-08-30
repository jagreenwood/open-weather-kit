//
//  Wind.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct Wind {

    /// General indicator of wind direction, often referred to as "due north", "due south", etc.
    /// Refers to the direction the wind is coming from, for instance, a north wind blows from
    /// north to south.
    public var compassDirection: Wind.CompassDirection

    /// Direction the wind is coming from in degrees, with true north at 0 and progressing clockwise from north.
    public var direction: Measurement<UnitAngle>

    /// Sustained wind speed.
    public var speed: Measurement<UnitSpeed>

    /// Wind gust speed, or the sudden increase in wind speed due to friction, wind shear, or by heating.
    public var gust: Measurement<UnitSpeed>?

    /// Specifies the 16-wind compass rose composed of the cardinal directions—north, east, south, and
    /// west—and its intercardinal directions. `Wind.CompassDirection` represents true headings.
    /// It's the direction the wind is coming from in degrees, measured clockwise from true north.
    @frozen public enum CompassDirection : String, Codable, CaseIterable, CustomStringConvertible {

        case north

        case northNortheast

        case northeast

        case eastNortheast

        case east

        case eastSoutheast

        case southeast

        case southSoutheast

        case south

        case southSouthwest

        case southwest

        case westSouthwest

        case west

        case westNorthwest

        case northwest

        case northNorthwest

        ///
        /// The short abbreviation of the wind compass direction, e.g. .north is "N".
        ///
        public var abbreviation: String {
            fatalError("not implemented")
        }

        /// Localized string describing the wind compass direction. Represents the direction the
        /// wind is coming from.
        public var description: String {
            fatalError("not implemented")
        }

        ///
        /// A description of the wind compass direction suitable for use in accessibility strings for
        /// Voice Over and other assistive technologies, e.g. .northNortheast is "North Northeast".
        ///
        public var accessibilityDescription: String {
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
        public typealias AllCases = [Wind.CompassDirection]

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        public typealias RawValue = String

        /// A collection of all values of this type.
        public static var allCases: [Wind.CompassDirection] {
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

extension Wind: Codable {}
extension Wind: Equatable {}
