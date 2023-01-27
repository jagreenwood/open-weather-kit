//
//  Wind.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// Contains wind data of speed, direction, and gust.
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct Wind: Sendable {

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
    @frozen public enum CompassDirection : String, Codable, CaseIterable, CustomStringConvertible, Sendable {

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
                return NSLocalizedString("Wind.abbreviation.north", bundle: Bundle.main, comment: "N")
            case .northNortheast:
                return NSLocalizedString("Wind.abbreviation.northNortheast", bundle: Bundle.main, comment: "NNE")
            case .northeast:
                return NSLocalizedString("Wind.abbreviation.northeast", bundle: Bundle.main, comment: "NE")
            case .eastNortheast:
                return NSLocalizedString("Wind.abbreviation.eastNortheast", bundle: Bundle.main, comment: "ENE")
            case .east:
                return NSLocalizedString("Wind.abbreviation.east", bundle: Bundle.main, comment: "E")
            case .eastSoutheast:
                return NSLocalizedString("Wind.abbreviation.eastSoutheast", bundle: Bundle.main, comment: "ESE")
            case .southeast:
                return NSLocalizedString("Wind.abbreviation.southeast", bundle: Bundle.main, comment: "SE")
            case .southSoutheast:
                return NSLocalizedString("Wind.abbreviation.southSoutheast", bundle: Bundle.main, comment: "SSE")
            case .south:
                return NSLocalizedString("Wind.abbreviation.south", bundle: Bundle.main, comment: "S")
            case .southSouthwest:
                return NSLocalizedString("Wind.abbreviation.southSouthwest", bundle: Bundle.main, comment: "SSW")
            case .southwest:
                return NSLocalizedString("Wind.abbreviation.southwest", bundle: Bundle.main, comment: "SW")
            case .westSouthwest:
                return NSLocalizedString("Wind.abbreviation.westSouthwest", bundle: Bundle.main, comment: "WSW")
            case .west:
                return NSLocalizedString("Wind.abbreviation.west", bundle: Bundle.main, comment: "W")
            case .westNorthwest:
                return NSLocalizedString("Wind.abbreviation.westNorthwest", bundle: Bundle.main, comment: "WNW")
            case .northwest:
                return NSLocalizedString("Wind.abbreviation.northwest", bundle: Bundle.main, comment: "NW")
            case .northNorthwest:
                return NSLocalizedString("Wind.abbreviation.northNorthwest", bundle: Bundle.main, comment: "NNW")
            case .undefined:
                return NSLocalizedString("Wind.abbreviation.undefined", bundle: Bundle.main, comment: "Undefined")
            }
        }

        /// Localized string describing the wind compass direction. Represents the direction the
        /// wind is coming from.
        public var description: String {
            switch self {
            case .north:
                return NSLocalizedString("Wind.north", bundle: Bundle.main, comment: "North")
            case .northNortheast:
                return NSLocalizedString("Wind.northNortheast", bundle: Bundle.main, comment: "North Northeast")
            case .northeast:
                return NSLocalizedString("Wind.northeast", bundle: Bundle.main, comment: "Northeast")
            case .eastNortheast:
                return NSLocalizedString("Wind.eastNortheast", bundle: Bundle.main, comment: "East Northeast")
            case .east:
                return NSLocalizedString("Wind.east", bundle: Bundle.main, comment: "East")
            case .eastSoutheast:
                return NSLocalizedString("Wind.eastSoutheast", bundle: Bundle.main, comment: "East Souteast")
            case .southeast:
                return NSLocalizedString("Wind.southeast", bundle: Bundle.main, comment: "Southeast")
            case .southSoutheast:
                return NSLocalizedString("Wind.southSoutheast", bundle: Bundle.main, comment: "South")
            case .south:
                return NSLocalizedString("Wind.south", bundle: Bundle.main, comment: "South Southeast")
            case .southSouthwest:
                return NSLocalizedString("Wind.southSouthwest", bundle: Bundle.main, comment: "South Southwest")
            case .southwest:
                return NSLocalizedString("Wind.southwest", bundle: Bundle.main, comment: "Southwest")
            case .westSouthwest:
                return NSLocalizedString("Wind.westSouthwest", bundle: Bundle.main, comment: "West Southwest")
            case .west:
                return NSLocalizedString("Wind.west", bundle: Bundle.main, comment: "West")
            case .westNorthwest:
                return NSLocalizedString("Wind.westNorthwest", bundle: Bundle.main, comment: "West Northwest")
            case .northwest:
                return NSLocalizedString("Wind.northwest", bundle: Bundle.main, comment: "Northwest")
            case .northNorthwest:
                return NSLocalizedString("Wind.northNorthwest", bundle: Bundle.main, comment: "North Northwest")
            case .undefined:
                return NSLocalizedString("Wind.undefined", bundle: Bundle.main, comment: "Undefined")
            }
        }

        ///
        /// A description of the wind compass direction suitable for use in accessibility strings for
        /// Voice Over and other assistive technologies, e.g. .northNortheast is "North Northeast".
        ///
        public var accessibilityDescription: String {
            switch self {
            case .north:
                return NSLocalizedString("Wind.accessibility.north", bundle: Bundle.main, comment: "North")
            case .northNortheast:
                return NSLocalizedString("Wind.accessibility.northNortheast", bundle: Bundle.main, comment: "North Northeast")
            case .northeast:
                return NSLocalizedString("Wind.accessibility.northeast", bundle: Bundle.main, comment: "Northeast")
            case .eastNortheast:
                return NSLocalizedString("Wind.accessibility.eastNortheast", bundle: Bundle.main, comment: "East Northeast")
            case .east:
                return NSLocalizedString("Wind.accessibility.east", bundle: Bundle.main, comment: "East")
            case .eastSoutheast:
                return NSLocalizedString("Wind.accessibility.eastSoutheast", bundle: Bundle.main, comment: "East Souteast")
            case .southeast:
                return NSLocalizedString("Wind.accessibility.southeast", bundle: Bundle.main, comment: "Southeast")
            case .southSoutheast:
                return NSLocalizedString("Wind.accessibility.southSoutheast", bundle: Bundle.main, comment: "South")
            case .south:
                return NSLocalizedString("Wind.accessibility.south", bundle: Bundle.main, comment: "South Southeast")
            case .southSouthwest:
                return NSLocalizedString("Wind.accessibility.southSouthwest", bundle: Bundle.main, comment: "South Southwest")
            case .southwest:
                return NSLocalizedString("Wind.accessibility.southwest", bundle: Bundle.main, comment: "Southwest")
            case .westSouthwest:
                return NSLocalizedString("Wind.accessibility.westSouthwest", bundle: Bundle.main, comment: "West Southwest")
            case .west:
                return NSLocalizedString("Wind.accessibility.west", bundle: Bundle.main, comment: "West")
            case .westNorthwest:
                return NSLocalizedString("Wind.accessibility.westNorthwest", bundle: Bundle.main, comment: "West Northwest")
            case .northwest:
                return NSLocalizedString("Wind.accessibility.northwest", bundle: Bundle.main, comment: "Northwest")
            case .northNorthwest:
                return NSLocalizedString("Wind.accessibility.northNorthwest", bundle: Bundle.main, comment: "North Northwest")
            case .undefined:
                return NSLocalizedString("Wind.accessibility.undefined", bundle: Bundle.main, comment: "Undefined")
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
