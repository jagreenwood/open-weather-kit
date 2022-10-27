//
//  Certainty.swift
//  
//
//  Created by Jeremy Greenwood on 10/26/22.
//

import Foundation

public enum Certainty: String, Codable, Equatable {
    
    // The event has already occurred or is ongoing.
    case observed

    // The event is likely to occur (greater than 50% probability).
    case likely

    // The event is unlikley to occur (less than 50% probability).
    case possible

    // The event is not expected to occur (approximately 0% probability).
    case unlikely

    // It is unknown if the event will occur.
    case unknown
}
