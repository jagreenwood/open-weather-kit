//
//  WeatherError.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// An error WeatherKit returns.
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public enum WeatherError : LocalizedError, Equatable, Hashable {
    /// Could not find country code
    case countryCode

    /// An error indicating permission denied.
    case permissionDenied

    /// An unknown error.
    case unknown

    case missingData(_ attributeName: String)

    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .countryCode: return NSLocalizedString("Error.countryCode", bundle: Bundle.main, comment: "Could not determine country code")
        case .permissionDenied:
            return NSLocalizedString("Error.permissionDenied", bundle: Bundle.main, comment: "Permission Denied")
        case .unknown:
            return NSLocalizedString("Error.unknown", bundle: Bundle.main, comment: "Unknown Error")
        case let .missingData(name):
            return String(format: NSLocalizedString("Error.missingData", bundle: Bundle.main, comment: "The data \(name) is missing from the response"), name)
        }
    }

    /// A localized message describing the reason for the failure.
    public var failureReason: String? {
        switch self {
        case .countryCode: return NSLocalizedString("Error.countryCode", bundle: Bundle.main, comment: "Could not determine country code")
        case .permissionDenied:
            return NSLocalizedString("Error.permissionDenied", bundle: Bundle.main, comment: "Permission Denied")
        case .unknown:
            return NSLocalizedString("Error.unknown", bundle: Bundle.main, comment: "Unknown Error")
        case let .missingData(name):
            return String(format: NSLocalizedString("Error.missingData", bundle: Bundle.main, comment: "The data \(name) is missing from the response"), name)
        }
    }


    /// A localized message providing text if the user requests help.
    public var helpAnchor: String? { nil }


    /// A localized message describing how to recover from the failure.
    public var recoverySuggestion: String? { nil }
}
