//
//  PressureTrend.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public enum PressureTrend : String, CaseIterable, CustomStringConvertible, Hashable {

    /// The pressure is rising.
    case rising

    /// The pressure is falling.
    case falling

    /// The pressure is not changing.
    case steady

    case undefined

    /// The localized string describing the pressure trend.
    public var description: String {
        switch self {
        case .rising:
            return NSLocalizedString("PressureTrend.rising", bundle: Bundle.main, comment: "Rising")
        case .falling:
            return NSLocalizedString("PressureTrend.falling", bundle: Bundle.main, comment: "Falling")
        case .steady:
            return NSLocalizedString("PressureTrend.steady", bundle: Bundle.main, comment: "Steady")
        case .undefined:
            return NSLocalizedString("PressureTrend.undefined", bundle: Bundle.main, comment: "Undefined")
        }
    }

    /// A localized accessibility description describing the pressure change over time,
    /// suitable for Voice Over and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .rising:
            return NSLocalizedString("PressureTrend.accessibility.rising", bundle: Bundle.main, comment: "Rising")
        case .falling:
            return NSLocalizedString("PressureTrend.accessibility.falling", bundle: Bundle.main, comment: "Falling")
        case .steady:
            return NSLocalizedString("PressureTrend.accessibility.steady", bundle: Bundle.main, comment: "Steady")
        case .undefined:
            return NSLocalizedString("PressureTrend.accessibility.undefined", bundle: Bundle.main, comment: "Undefined")
        }
    }
}

extension PressureTrend: Codable {}
extension PressureTrend: Equatable {}
