//
//  MoonPhase.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

@frozen public enum MoonPhase : String, CustomStringConvertible, CaseIterable {

    /// The disk is unlit where the moon is not visible.
    case new

    /// The disk is partially lit as the moon is waxing.
    case waxingCrescent

    /// The disk is half lit.
    case firstQuarter

    /// The disk is half lit as the moon is waxing.
    case waxingGibbous

    /// The disk is fully lit where the moon is visible.
    case full

    /// The disk is half lit as the moon is waning.
    case waningGibbous

    /// The disk is half lit.
    case lastQuarter

    /// The disk is partially lit as the moon is waning.
    case waningCrescent

    /// A localized string describing the moon phase.
    public var description: String {
        fatalError("not implemented")
    }

    /// A localized accessibility description describing the moon phase, suitable for Voice Over
    /// and other assistive technologies.
    public var accessibilityDescription: String {
        fatalError("not implemented")
    }

    ///
    /// The SF Symbol icon that represents the moon phase.
    ///
    public var symbolName: String {
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
    public typealias AllCases = [MoonPhase]

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    public typealias RawValue = String

    /// A collection of all values of this type.
    public static var allCases: [MoonPhase] {
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

extension MoonPhase: Codable {}
extension MoonPhase: Equatable {}
