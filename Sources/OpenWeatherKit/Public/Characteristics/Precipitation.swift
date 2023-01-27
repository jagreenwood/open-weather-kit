//
//  Precipitation.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// The form of precipitation.
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public enum Precipitation : String, CaseIterable, CustomStringConvertible, Hashable, Sendable {

    /// No precipitation.
    case none

    /// A form of precipitation consisting of solid ice.
    case hail

    /// Mixed precipitation.
    case mixed

    /// Rain.
    case rain

    /// A form of precipitation consisting of ice pellets.
    case sleet

    /// Snow.
    case snow

    /// A localized string describing the form of precipitation.
    public var description: String {
        switch self {
        case .none:
            return NSLocalizedString("Precipitation.none", bundle: Bundle.main, comment: "None")
        case .hail:
            return NSLocalizedString("Precipitation.hail", bundle: Bundle.main, comment: "Hail")
        case .mixed:
            return NSLocalizedString("Precipitation.mixed", bundle: Bundle.main, comment: "Mixed")
        case .rain:
            return NSLocalizedString("Precipitation.rain", bundle: Bundle.main, comment: "Rain")
        case .sleet:
            return NSLocalizedString("Precipitation.sleet", bundle: Bundle.main, comment: "Sleet")
        case .snow:
            return NSLocalizedString("Precipitation.snow", bundle: Bundle.main, comment: "Snow")
        }
    }

    /// A localized accessibility description describing the form of precipitation, suitable for
    /// Voice Over and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .none:
            return NSLocalizedString("Precipitation.accessibility.none", bundle: Bundle.main, comment: "None")
        case .hail:
            return NSLocalizedString("Precipitation.accessibility.hail", bundle: Bundle.main, comment: "Hail")
        case .mixed:
            return NSLocalizedString("Precipitation.accessibility.mixed", bundle: Bundle.main, comment: "Mixed")
        case .rain:
            return NSLocalizedString("Precipitation.accessibility.rain", bundle: Bundle.main, comment: "Rain")
        case .sleet:
            return NSLocalizedString("Precipitation.accessibility.sleet", bundle: Bundle.main, comment: "Sleet")
        case .snow:
            return NSLocalizedString("Precipitation.accessibility.snow", bundle: Bundle.main, comment: "Snow")
        }
    }
}

extension Precipitation: Codable {}
extension Precipitation: Equatable {}
