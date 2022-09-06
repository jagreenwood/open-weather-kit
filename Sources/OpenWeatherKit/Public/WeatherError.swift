//
//  WeatherError.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public enum WeatherError : LocalizedError {

    /// An error indicating permission denied.
    case permissionDenied

    /// An unknown error.
    case unknown

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


    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: WeatherError, b: WeatherError) -> Bool {
        fatalError("not implemented")
    }


    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher) {
        fatalError("not implemented")
    }


    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int {
        fatalError("not implemented")
    }
}
