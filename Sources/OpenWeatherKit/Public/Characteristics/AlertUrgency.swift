//
//  AlertUrgency.swift
//  
//
//  Created by Jeremy Greenwood on 10/26/22.
//

import Foundation

/// The urgency of the weather alert
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public enum AlertUrgency: String, Codable, Equatable, Sendable {
    // Take responsive action immediately.
    case immediate

    // Take responsive action in the next hour.
    case expected

    // Take responsive action in the near future.
    case future

    // Responsive action is no longer required.
    case past

    // The urgency is unknown.
    case unknown

}
