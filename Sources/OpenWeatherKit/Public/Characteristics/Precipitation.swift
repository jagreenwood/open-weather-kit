//
//  Precipitation.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// The form of precipitation.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
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
            return NSLocalizedString("Precipitation.none", bundle: Bundle.module, comment: "None")
        case .hail:
            return NSLocalizedString("Precipitation.hail", bundle: Bundle.module, comment: "Hail")
        case .mixed:
            return NSLocalizedString("Precipitation.mixed", bundle: Bundle.module, comment: "Mixed")
        case .rain:
            return NSLocalizedString("Precipitation.rain", bundle: Bundle.module, comment: "Rain")
        case .sleet:
            return NSLocalizedString("Precipitation.sleet", bundle: Bundle.module, comment: "Sleet")
        case .snow:
            return NSLocalizedString("Precipitation.snow", bundle: Bundle.module, comment: "Snow")
        }
    }

    /// A localized accessibility description describing the form of precipitation, suitable for
    /// Voice Over and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .none:
            return NSLocalizedString("Precipitation.accessibility.none", bundle: Bundle.module, comment: "None")
        case .hail:
            return NSLocalizedString("Precipitation.accessibility.hail", bundle: Bundle.module, comment: "Hail")
        case .mixed:
            return NSLocalizedString("Precipitation.accessibility.mixed", bundle: Bundle.module, comment: "Mixed")
        case .rain:
            return NSLocalizedString("Precipitation.accessibility.rain", bundle: Bundle.module, comment: "Rain")
        case .sleet:
            return NSLocalizedString("Precipitation.accessibility.sleet", bundle: Bundle.module, comment: "Sleet")
        case .snow:
            return NSLocalizedString("Precipitation.accessibility.snow", bundle: Bundle.module, comment: "Snow")
        }
    }
}

extension Precipitation: Codable {}
extension Precipitation: Equatable {}
