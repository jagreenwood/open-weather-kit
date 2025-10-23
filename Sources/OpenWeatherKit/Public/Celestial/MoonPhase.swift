//
//  MoonPhase.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// An enumeration that specifies the moon phase kind.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
@frozen public enum MoonPhase : String, CustomStringConvertible, CaseIterable {

    /// The disk is unlit where the moon is not visible.
    case new = "new"

    /// The disk is partially lit as the moon is waxing.
    case waxingCrescent = "waxing_crescent"

    /// The disk is half lit.
    case firstQuarter = "first_quarter"

    /// The disk is half lit as the moon is waxing.
    case waxingGibbous = "waxing_gibbous"

    /// The disk is fully lit where the moon is visible.
    case full = "full"

    /// The disk is half lit as the moon is waning.
    case waningGibbous = "waning_gibbous"

    /// The disk is half lit.
    case lastQuarter = "last_quarter"

    /// The disk is partially lit as the moon is waning.
    case waningCrescent = "waning_crescent"

    /// A localized string describing the moon phase.
    public var description: String {
        switch self {
        case .new:
            return NSLocalizedString("MoonPhase.new", bundle: Bundle.module, comment: "New")
        case .waxingCrescent:
            return NSLocalizedString("MoonPhase.waxingCrescent", bundle: Bundle.module, comment: "WaxingCrescent")
        case .firstQuarter:
            return NSLocalizedString("MoonPhase.firstQuarter", bundle: Bundle.module, comment: "FirstQuarter")
        case .waxingGibbous:
            return NSLocalizedString("MoonPhase.waxingGibbous", bundle: Bundle.module, comment: "WaxingGibbous")
        case .full:
            return NSLocalizedString("MoonPhase.full", bundle: Bundle.module, comment: "Full")
        case .waningGibbous:
            return NSLocalizedString("MoonPhase.waningGibbous", bundle: Bundle.module, comment: "WaningGibbous")
        case .lastQuarter:
            return NSLocalizedString("MoonPhase.lastQuarter", bundle: Bundle.module, comment: "LastQuarter")
        case .waningCrescent:
            return NSLocalizedString("MoonPhase.waningCrescent", bundle: Bundle.module, comment: "WaningCrescent")
        }
    }

    /// A localized accessibility description describing the moon phase, suitable for Voice Over
    /// and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .new:
            return NSLocalizedString("MoonPhase.accessibility.new", bundle: Bundle.module, comment: "New")
        case .waxingCrescent:
            return NSLocalizedString("MoonPhase.accessibility.waxingCrescent", bundle: Bundle.module, comment: "WaxingCrescent")
        case .firstQuarter:
            return NSLocalizedString("MoonPhase.accessibility.firstQuarter", bundle: Bundle.module, comment: "FirstQuarter")
        case .waxingGibbous:
            return NSLocalizedString("MoonPhase.accessibility.waxingGibbous", bundle: Bundle.module, comment: "WaxingGibbous")
        case .full:
            return NSLocalizedString("MoonPhase.accessibility.full", bundle: Bundle.module, comment: "Full")
        case .waningGibbous:
            return NSLocalizedString("MoonPhase.accessibility.waningGibbous", bundle: Bundle.module, comment: "WaningGibbous")
        case .lastQuarter:
            return NSLocalizedString("MoonPhase.accessibility.lastQuarter", bundle: Bundle.module, comment: "LastQuarter")
        case .waningCrescent:
            return NSLocalizedString("MoonPhase.accessibility.waningCrescent", bundle: Bundle.module, comment: "WaningCrescent")
        }
    }

    ///
    /// The SF Symbol icon that represents the moon phase.
    ///
    public var symbolName: String {
        switch self {
        case .new: return "moonphase.new.moon"
        case .waxingCrescent: return "moonphase.waxing.crescent"
        case .firstQuarter: return "moonphase.first.quarter"
        case .waxingGibbous: return "moonphase.waxing.gibbous"
        case .full: return "moonphase.full.moon"
        case .waningGibbous: return "moonphase.waning.gibbous"
        case .lastQuarter: return "moonphase.last.quarter"
        case .waningCrescent: return "moonphase.waning.crescent"
        }
    }
}

extension MoonPhase: Codable {}
extension MoonPhase: Equatable {}
