//
//  WeatherCondition.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public enum WeatherCondition : String, CaseIterable, CustomStringConvertible, Hashable {

    /// The kind of condition.
    case blizzard

    case blowingDust

    case blowingSnow

    case breezy

    case clear

    case cloudy

    case drizzle

    case flurries

    case foggy

    case freezingDrizzle

    case freezingRain

    case frigid

    case hail

    case haze

    case heavyRain

    case heavySnow

    case hot

    case hurricane

    case isolatedThunderstorms

    case mostlyClear

    case mostlyCloudy

    case partlyCloudy

    case rain

    case scatteredThunderstorms

    case sleet

    case smoky

    case snow

    case strongStorms

    case sunFlurries

    case sunShowers

    case thunderstorms

    case tropicalStorm

    case undefined

    case windy

    case wintryMix

    /// Standard string describing the current condition.
    public var description: String {
        fatalError("not implemented")
    }

    /// A localized accessibility description describing the weather condition, suitable for
    /// Voice Over and other assistive technologies.
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
    public typealias AllCases = [WeatherCondition]

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    public typealias RawValue = String

    /// A collection of all values of this type.
    public static var allCases: [WeatherCondition] {
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

extension WeatherCondition {
    var sfSymbol: String {
        fatalError("not implemented")
    }
}

extension WeatherCondition: Codable {}
extension WeatherCondition: Equatable {}
