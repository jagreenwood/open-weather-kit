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
            return NSLocalizedString("WeatherSeverity.minor", bundle: Bundle.main, comment: "Minor")
        case .moderate:
            return NSLocalizedString("WeatherSeverity.moderate", bundle: Bundle.main, comment: "Moderate")
        case .severe:
            return NSLocalizedString("WeatherSeverity.severe", bundle: Bundle.main, comment: "Severe")
        case .extreme:
            return NSLocalizedString("WeatherSeverity.extreme", bundle: Bundle.main, comment: "Extreme")
        case .unknown:
            return NSLocalizedString("WeatherSeverity.unknown", bundle: Bundle.main, comment: "Unknown")
        }
    }

    /// A localized accessibility description describing the weather severity, suitable for
    /// Voice Over and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .minor:
            return NSLocalizedString("WeatherSeverity.accessibility.minor", bundle: Bundle.main, comment: "Minor")
        case .moderate:
            return NSLocalizedString("WeatherSeverity.accessibility.moderate", bundle: Bundle.main, comment: "Moderate")
        case .severe:
            return NSLocalizedString("WeatherSeverity.accessibility.severe", bundle: Bundle.main, comment: "Severe")
        case .extreme:
            return NSLocalizedString("WeatherSeverity.accessibility.extreme", bundle: Bundle.main, comment: "Extreme")
        case .unknown:
            return NSLocalizedString("WeatherSeverity.accessibility.unknown", bundle: Bundle.main, comment: "Unknown")
        }
    }
}
