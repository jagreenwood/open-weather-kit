//
//  MoonEvents.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// A structure that represents lunar events.
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct MoonEvents: Sendable {

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
