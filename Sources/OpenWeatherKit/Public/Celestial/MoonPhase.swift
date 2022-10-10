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
            return NSLocalizedString("MoonPhase.new", bundle: BundleLocator.bundle, comment: "New")
        case .waxingCrescent:
            return NSLocalizedString("MoonPhase.waxingCrescent", bundle: BundleLocator.bundle, comment: "WaxingCrescent")
        case .firstQuarter:
            return NSLocalizedString("MoonPhase.firstQuarter", bundle: BundleLocator.bundle, comment: "FirstQuarter")
        case .waxingGibbous:
            return NSLocalizedString("MoonPhase.waxingGibbous", bundle: BundleLocator.bundle, comment: "WaxingGibbous")
        case .full:
            return NSLocalizedString("MoonPhase.full", bundle: BundleLocator.bundle, comment: "Full")
        case .waningGibbous:
            return NSLocalizedString("MoonPhase.waningGibbous", bundle: BundleLocator.bundle, comment: "WaningGibbous")
        case .lastQuarter:
            return NSLocalizedString("MoonPhase.lastQuarter", bundle: BundleLocator.bundle, comment: "LastQuarter")
        case .waningCrescent:
            return NSLocalizedString("MoonPhase.waningCrescent", bundle: BundleLocator.bundle, comment: "WaningCrescent")
        }
    }

    /// A localized accessibility description describing the moon phase, suitable for Voice Over
    /// and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .new:
            return NSLocalizedString("MoonPhase.accessibility.new", bundle: BundleLocator.bundle, comment: "New")
        case .waxingCrescent:
            return NSLocalizedString("MoonPhase.accessibility.waxingCrescent", bundle: BundleLocator.bundle, comment: "WaxingCrescent")
        case .firstQuarter:
            return NSLocalizedString("MoonPhase.accessibility.firstQuarter", bundle: BundleLocator.bundle, comment: "FirstQuarter")
        case .waxingGibbous:
            return NSLocalizedString("MoonPhase.accessibility.waxingGibbous", bundle: BundleLocator.bundle, comment: "WaxingGibbous")
        case .full:
            return NSLocalizedString("MoonPhase.accessibility.full", bundle: BundleLocator.bundle, comment: "Full")
        case .waningGibbous:
            return NSLocalizedString("MoonPhase.accessibility.waningGibbous", bundle: BundleLocator.bundle, comment: "WaningGibbous")
        case .lastQuarter:
            return NSLocalizedString("MoonPhase.accessibility.lastQuarter", bundle: BundleLocator.bundle, comment: "LastQuarter")
        case .waningCrescent:
            return NSLocalizedString("MoonPhase.accessibility.waningCrescent", bundle: BundleLocator.bundle, comment: "WaningCrescent")
        }
    }

    ///
    /// The SF Symbol icon that represents the moon phase.
    ///
    #warning("Implement sfSymbol")
    public var symbolName: String {
        switch self {
        case .new: return ""
        case .waxingCrescent: return ""
        case .firstQuarter: return ""
        case .waxingGibbous: return ""
        case .full: return ""
        case .waningGibbous: return ""
        case .lastQuarter: return ""
        case .waningCrescent: return ""
        }
    }
}

extension MoonPhase: Codable {}
extension MoonPhase: Equatable {}
