//
//  Precipitation.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public enum Precipitation : String, CaseIterable, CustomStringConvertible, Hashable {

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
            return NSLocalizedString("Precipitation.none", bundle: BundleLocator.bundle, comment: "None")
        case .hail:
            return NSLocalizedString("Precipitation.hail", bundle: BundleLocator.bundle, comment: "Hail")
        case .mixed:
            return NSLocalizedString("Precipitation.mixed", bundle: BundleLocator.bundle, comment: "Mixed")
        case .rain:
            return NSLocalizedString("Precipitation.rain", bundle: BundleLocator.bundle, comment: "Rain")
        case .sleet:
            return NSLocalizedString("Precipitation.sleet", bundle: BundleLocator.bundle, comment: "Sleet")
        case .snow:
            return NSLocalizedString("Precipitation.snow", bundle: BundleLocator.bundle, comment: "Snow")
        }
    }

    /// A localized accessibility description describing the form of precipitation, suitable for
    /// Voice Over and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .none:
            return NSLocalizedString("Precipitation.accessibility.none", bundle: BundleLocator.bundle, comment: "None")
        case .hail:
            return NSLocalizedString("Precipitation.accessibility.hail", bundle: BundleLocator.bundle, comment: "Hail")
        case .mixed:
            return NSLocalizedString("Precipitation.accessibility.mixed", bundle: BundleLocator.bundle, comment: "Mixed")
        case .rain:
            return NSLocalizedString("Precipitation.accessibility.rain", bundle: BundleLocator.bundle, comment: "Rain")
        case .sleet:
            return NSLocalizedString("Precipitation.accessibility.sleet", bundle: BundleLocator.bundle, comment: "Sleet")
        case .snow:
            return NSLocalizedString("Precipitation.accessibility.snow", bundle: BundleLocator.bundle, comment: "Snow")
        }
    }
}

extension Precipitation: Codable {}
extension Precipitation: Equatable {}
