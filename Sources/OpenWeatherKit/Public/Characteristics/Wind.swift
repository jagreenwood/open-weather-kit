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

        case undefined

        ///
        /// The short abbreviation of the wind compass direction, e.g. .north is "N".
        ///
        public var abbreviation: String {
            switch self {
            case .north:
                return NSLocalizedString("Wind.abbreviation.north", bundle: BundleLocator.bundle, comment: "N")
            case .northNortheast:
                return NSLocalizedString("Wind.abbreviation.northNortheast", bundle: BundleLocator.bundle, comment: "NNE")
            case .northeast:
                return NSLocalizedString("Wind.abbreviation.northeast", bundle: BundleLocator.bundle, comment: "NE")
            case .eastNortheast:
                return NSLocalizedString("Wind.abbreviation.eastNortheast", bundle: BundleLocator.bundle, comment: "ENE")
            case .east:
                return NSLocalizedString("Wind.abbreviation.east", bundle: BundleLocator.bundle, comment: "E")
            case .eastSoutheast:
                return NSLocalizedString("Wind.abbreviation.eastSoutheast", bundle: BundleLocator.bundle, comment: "ESE")
            case .southeast:
                return NSLocalizedString("Wind.abbreviation.southeast", bundle: BundleLocator.bundle, comment: "SE")
            case .southSoutheast:
                return NSLocalizedString("Wind.abbreviation.southSoutheast", bundle: BundleLocator.bundle, comment: "SSE")
            case .south:
                return NSLocalizedString("Wind.abbreviation.south", bundle: BundleLocator.bundle, comment: "S")
            case .southSouthwest:
                return NSLocalizedString("Wind.abbreviation.southSouthwest", bundle: BundleLocator.bundle, comment: "SSW")
            case .southwest:
                return NSLocalizedString("Wind.abbreviation.southwest", bundle: BundleLocator.bundle, comment: "SW")
            case .westSouthwest:
                return NSLocalizedString("Wind.abbreviation.westSouthwest", bundle: BundleLocator.bundle, comment: "WSW")
            case .west:
                return NSLocalizedString("Wind.abbreviation.west", bundle: BundleLocator.bundle, comment: "W")
            case .westNorthwest:
                return NSLocalizedString("Wind.abbreviation.westNorthwest", bundle: BundleLocator.bundle, comment: "WNW")
            case .northwest:
                return NSLocalizedString("Wind.abbreviation.northwest", bundle: BundleLocator.bundle, comment: "NW")
            case .northNorthwest:
                return NSLocalizedString("Wind.abbreviation.northNorthwest", bundle: BundleLocator.bundle, comment: "NNW")
            case .undefined:
                return NSLocalizedString("Wind.abbreviation.undefined", bundle: BundleLocator.bundle, comment: "Undefined")
            }
        }

        /// Localized string describing the wind compass direction. Represents the direction the
        /// wind is coming from.
        public var description: String {
            switch self {
            case .north:
                return NSLocalizedString("Wind.north", bundle: BundleLocator.bundle, comment: "North")
            case .northNortheast:
                return NSLocalizedString("Wind.northNortheast", bundle: BundleLocator.bundle, comment: "North-Northeast")
            case .northeast:
                return NSLocalizedString("Wind.northeast", bundle: BundleLocator.bundle, comment: "Northeast")
            case .eastNortheast:
                return NSLocalizedString("Wind.eastNortheast", bundle: BundleLocator.bundle, comment: "East-Northeast")
            case .east:
                return NSLocalizedString("Wind.east", bundle: BundleLocator.bundle, comment: "East")
            case .eastSoutheast:
                return NSLocalizedString("Wind.eastSoutheast", bundle: BundleLocator.bundle, comment: "East-Souteast")
            case .southeast:
                return NSLocalizedString("Wind.southeast", bundle: BundleLocator.bundle, comment: "Southeast")
            case .southSoutheast:
                return NSLocalizedString("Wind.southSoutheast", bundle: BundleLocator.bundle, comment: "South")
            case .south:
                return NSLocalizedString("Wind.south", bundle: BundleLocator.bundle, comment: "South-Southeast")
            case .southSouthwest:
                return NSLocalizedString("Wind.southSouthwest", bundle: BundleLocator.bundle, comment: "South-Southwest")
            case .southwest:
                return NSLocalizedString("Wind.southwest", bundle: BundleLocator.bundle, comment: "Southwest")
            case .westSouthwest:
                return NSLocalizedString("Wind.westSouthwest", bundle: BundleLocator.bundle, comment: "West-Southwest")
            case .west:
                return NSLocalizedString("Wind.west", bundle: BundleLocator.bundle, comment: "West")
            case .westNorthwest:
                return NSLocalizedString("Wind.westNorthwest", bundle: BundleLocator.bundle, comment: "West-Northwest")
            case .northwest:
                return NSLocalizedString("Wind.northwest", bundle: BundleLocator.bundle, comment: "Northwest")
            case .northNorthwest:
                return NSLocalizedString("Wind.northNorthwest", bundle: BundleLocator.bundle, comment: "North-Northwest")
            case .undefined:
                return NSLocalizedString("Wind.undefined", bundle: BundleLocator.bundle, comment: "Undefined")
            }
        }

        ///
        /// A description of the wind compass direction suitable for use in accessibility strings for
        /// Voice Over and other assistive technologies, e.g. .northNortheast is "North Northeast".
        ///
        public var accessibilityDescription: String {
            switch self {
            case .north:
                return NSLocalizedString("Wind.accessibility.north", bundle: BundleLocator.bundle, comment: "North")
            case .northNortheast:
                return NSLocalizedString("Wind.accessibility.northNortheast", bundle: BundleLocator.bundle, comment: "North-Northeast")
            case .northeast:
                return NSLocalizedString("Wind.accessibility.northeast", bundle: BundleLocator.bundle, comment: "Northeast")
            case .eastNortheast:
                return NSLocalizedString("Wind.accessibility.eastNortheast", bundle: BundleLocator.bundle, comment: "East-Northeast")
            case .east:
                return NSLocalizedString("Wind.accessibility.east", bundle: BundleLocator.bundle, comment: "East")
            case .eastSoutheast:
                return NSLocalizedString("Wind.accessibility.eastSoutheast", bundle: BundleLocator.bundle, comment: "East-Souteast")
            case .southeast:
                return NSLocalizedString("Wind.accessibility.southeast", bundle: BundleLocator.bundle, comment: "Southeast")
            case .southSoutheast:
                return NSLocalizedString("Wind.accessibility.southSoutheast", bundle: BundleLocator.bundle, comment: "South")
            case .south:
                return NSLocalizedString("Wind.accessibility.south", bundle: BundleLocator.bundle, comment: "South-Southeast")
            case .southSouthwest:
                return NSLocalizedString("Wind.accessibility.southSouthwest", bundle: BundleLocator.bundle, comment: "South-Southwest")
            case .southwest:
                return NSLocalizedString("Wind.accessibility.southwest", bundle: BundleLocator.bundle, comment: "Southwest")
            case .westSouthwest:
                return NSLocalizedString("Wind.accessibility.westSouthwest", bundle: BundleLocator.bundle, comment: "West-Southwest")
            case .west:
                return NSLocalizedString("Wind.accessibility.west", bundle: BundleLocator.bundle, comment: "West")
            case .westNorthwest:
                return NSLocalizedString("Wind.accessibility.westNorthwest", bundle: BundleLocator.bundle, comment: "West-Northwest")
            case .northwest:
                return NSLocalizedString("Wind.accessibility.northwest", bundle: BundleLocator.bundle, comment: "Northwest")
            case .northNorthwest:
                return NSLocalizedString("Wind.accessibility.northNorthwest", bundle: BundleLocator.bundle, comment: "North-Northwest")
            case .undefined:
                return NSLocalizedString("Wind.accessibility.undefined", bundle: BundleLocator.bundle, comment: "Undefined")
            }
        }

        init(value: Double) {
            switch value {
            case 0..<11.25: self = .north
            case 11.25..<33.75: self = .northNortheast
            case 33.75..<56.25: self = .northeast
            case 56.25..<78.75: self = .eastNortheast
            case 78.75..<101.25: self = .east
            case 101.25..<123.75: self = .eastSoutheast
            case 123.75..<146.25: self = .southeast
            case 146.25..<168.75: self = .southSoutheast
            case 168.75..<191.25: self = .south
            case 191.25..<213.75: self = .southSouthwest
            case 213.75..<236.25: self = .southwest
            case 236.25..<258.75: self = .westSouthwest
            case 258.75..<281.25: self = .west
            case 281.25..<303.75: self = .westNorthwest
            case 303.75..<326.25: self = .northwest
            case 326.25..<348.75: self = .northNorthwest
            case 348.75..<360.0: self = .north
            default: self = .undefined
            }
        }
    }
}

extension Wind: Codable {}
extension Wind: Equatable {}
