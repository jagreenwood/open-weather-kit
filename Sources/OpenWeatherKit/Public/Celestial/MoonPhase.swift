//
//  MoonPhase.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

@frozen public enum MoonPhase : String, CustomStringConvertible, CaseIterable {

    /// The disk is unlit where the moon is not visible.
    case new

    /// The disk is partially lit as the moon is waxing.
    case waxingCrescent

    /// The disk is half lit.
    case firstQuarter

    /// The disk is half lit as the moon is waxing.
    case waxingGibbous

    /// The disk is fully lit where the moon is visible.
    case full

    /// The disk is half lit as the moon is waning.
    case waningGibbous

    /// The disk is half lit.
    case lastQuarter

    /// The disk is partially lit as the moon is waning.
    case waningCrescent

    /// A localized string describing the moon phase.
    public var description: String {
        switch self {
        case .new:
            return NSLocalizedString("MoonPhase.new", bundle: Bundle.main, comment: "New")
        case .waxingCrescent:
            return NSLocalizedString("MoonPhase.waxingCrescent", bundle: Bundle.main, comment: "WaxingCrescent")
        case .firstQuarter:
            return NSLocalizedString("MoonPhase.firstQuarter", bundle: Bundle.main, comment: "FirstQuarter")
        case .waxingGibbous:
            return NSLocalizedString("MoonPhase.waxingGibbous", bundle: Bundle.main, comment: "WaxingGibbous")
        case .full:
            return NSLocalizedString("MoonPhase.full", bundle: Bundle.main, comment: "Full")
        case .waningGibbous:
            return NSLocalizedString("MoonPhase.waningGibbous", bundle: Bundle.main, comment: "WaningGibbous")
        case .lastQuarter:
            return NSLocalizedString("MoonPhase.lastQuarter", bundle: Bundle.main, comment: "LastQuarter")
        case .waningCrescent:
            return NSLocalizedString("MoonPhase.waningCrescent", bundle: Bundle.main, comment: "WaningCrescent")
        }
    }

    /// A localized accessibility description describing the moon phase, suitable for Voice Over
    /// and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .new:
            return NSLocalizedString("MoonPhase.accessibility.new", bundle: Bundle.main, comment: "New")
        case .waxingCrescent:
            return NSLocalizedString("MoonPhase.accessibility.waxingCrescent", bundle: Bundle.main, comment: "WaxingCrescent")
        case .firstQuarter:
            return NSLocalizedString("MoonPhase.accessibility.firstQuarter", bundle: Bundle.main, comment: "FirstQuarter")
        case .waxingGibbous:
            return NSLocalizedString("MoonPhase.accessibility.waxingGibbous", bundle: Bundle.main, comment: "WaxingGibbous")
        case .full:
            return NSLocalizedString("MoonPhase.accessibility.full", bundle: Bundle.main, comment: "Full")
        case .waningGibbous:
            return NSLocalizedString("MoonPhase.accessibility.waningGibbous", bundle: Bundle.main, comment: "WaningGibbous")
        case .lastQuarter:
            return NSLocalizedString("MoonPhase.accessibility.lastQuarter", bundle: Bundle.main, comment: "LastQuarter")
        case .waningCrescent:
            return NSLocalizedString("MoonPhase.accessibility.waningCrescent", bundle: Bundle.main, comment: "WaningCrescent")
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
