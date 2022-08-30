//
//  MoonEvents.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct MoonEvents {

    /// The moon phase.
    public var phase: MoonPhase

    /// The date of moonrise. Moonrise occurs when the moon first appears above Earth’s horizon.
    public var moonrise: Date?

    /// The date of moonset.
    ///
    /// Moonset occurs when the moon sets below Earth's horizon.
    public var moonset: Date?
}

extension MoonEvents: Codable {}
extension MoonEvents: Equatable {}
