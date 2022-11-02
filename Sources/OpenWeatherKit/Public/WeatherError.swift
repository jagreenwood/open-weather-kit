//
//  WeatherError.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public enum WeatherError : LocalizedError, Equatable, Hashable {

    /// An error indicating permission denied.
    case permissionDenied

    /// An unknown error.
    case unknown

    case missingData(_ attributeName: String)

    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        fatalError("not implemented")
    }

    /// A localized message describing the reason for the failure.
    public var failureReason: String? {
        fatalError("not implemented")
    }


    /// A localized message providing text if the user requests help.
    public var helpAnchor: String? {
        fatalError("not implemented")
    }


    /// A localized message describing how to recover from the failure.
    public var recoverySuggestion: String? {
        fatalError("not implemented")
    }
}
