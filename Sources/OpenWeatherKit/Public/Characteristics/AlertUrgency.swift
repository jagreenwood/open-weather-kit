//
//  AlertUrgency.swift
//  
//
//  Created by Jeremy Greenwood on 10/26/22.
//

import Foundation

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
