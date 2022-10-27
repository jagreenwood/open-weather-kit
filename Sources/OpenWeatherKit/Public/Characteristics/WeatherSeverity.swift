//
//  WeatherSeverity.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public enum WeatherSeverity : String, Codable, CaseIterable, CustomStringConvertible, Hashable {

    /// Specifies "minimal" or no threat to life or property.
    case minor

    /// Specifies "possible" threat to life or property.
    case moderate

    /// Specifies "significant" threat to life or property.
    case severe

    /// Specifies "extraordinary" threat to life or property.
    case extreme

    /// Specifies unknown severity.
    case unknown

    /// Localized string describing the weather severity.
    public var description: String {
        switch self {
        case .minor:
            return NSLocalizedString("WeatherSeverity.minor", bundle: BundleLocator.bundle, comment: "Minor")
        case .moderate:
            return NSLocalizedString("WeatherSeverity.moderate", bundle: BundleLocator.bundle, comment: "Moderate")
        case .severe:
            return NSLocalizedString("WeatherSeverity.severe", bundle: BundleLocator.bundle, comment: "Severe")
        case .extreme:
            return NSLocalizedString("WeatherSeverity.extreme", bundle: BundleLocator.bundle, comment: "Extreme")
        case .unknown:
            return NSLocalizedString("WeatherSeverity.unknown", bundle: BundleLocator.bundle, comment: "Unknown")
        }
    }

    /// A localized accessibility description describing the weather severity, suitable for
    /// Voice Over and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .minor:
            return NSLocalizedString("WeatherSeverity.accessibility.minor", bundle: BundleLocator.bundle, comment: "Minor")
        case .moderate:
            return NSLocalizedString("WeatherSeverity.accessibility.moderate", bundle: BundleLocator.bundle, comment: "Moderate")
        case .severe:
            return NSLocalizedString("WeatherSeverity.accessibility.severe", bundle: BundleLocator.bundle, comment: "Severe")
        case .extreme:
            return NSLocalizedString("WeatherSeverity.accessibility.extreme", bundle: BundleLocator.bundle, comment: "Extreme")
        case .unknown:
            return NSLocalizedString("WeatherSeverity.accessibility.unknown", bundle: BundleLocator.bundle, comment: "Unknown")
        }
    }
}
