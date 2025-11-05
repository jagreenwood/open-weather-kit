//
//  WeatherError.swift
//
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// An error WeatherKit returns.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public enum WeatherError : LocalizedError, Equatable, Hashable {
    /// Could not find country code
    case countryCode

    /// An error indicating permission denied.
    case permissionDenied

    /// An unknown error.
    case unknown

    /// Could not find timezone
    case timezone

    case missingData(_ attributeName: String)

    /// An invalid request parameter.
    case invalidRequest(_ message: String)

    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .countryCode: return NSLocalizedString("Error.countryCode", bundle: Bundle.module, comment: "Could not determine country code")
        case .permissionDenied:
            return NSLocalizedString("Error.permissionDenied", bundle: Bundle.module, comment: "Permission Denied")
        case .unknown:
            return NSLocalizedString("Error.unknown", bundle: Bundle.module, comment: "Unknown Error")
        case .timezone:
            return NSLocalizedString("Error.timezone", bundle: Bundle.module, comment: "Could not determine timezone")
        case let .missingData(name):
            return String(format: NSLocalizedString("Error.missingData", bundle: Bundle.module, comment: "The data \(name) is missing from the response"), name)
        case let .invalidRequest(message):
            return message
        }
    }

    /// A localized message describing the reason for the failure.
    public var failureReason: String? {
        switch self {
        case .countryCode: return NSLocalizedString("Error.countryCode", bundle: Bundle.module, comment: "Could not determine country code")
        case .permissionDenied:
            return NSLocalizedString("Error.permissionDenied", bundle: Bundle.module, comment: "Permission Denied")
        case .unknown:
            return NSLocalizedString("Error.unknown", bundle: Bundle.module, comment: "Unknown Error")
        case .timezone:
            return NSLocalizedString("Error.timezone", bundle: Bundle.module, comment: "Could not determine timezone")
        case let .missingData(name):
            return String(format: NSLocalizedString("Error.missingData", bundle: Bundle.module, comment: "The data \(name) is missing from the response"), name)
        case let .invalidRequest(message):
            return message
        }
    }


    /// A localized message providing text if the user requests help.
    public var helpAnchor: String? { nil }


    /// A localized message describing how to recover from the failure.
    public var recoverySuggestion: String? { nil }
}
