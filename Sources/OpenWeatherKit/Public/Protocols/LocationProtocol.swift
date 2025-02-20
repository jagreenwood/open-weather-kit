//
//  Location.swift
//  
//
//  Created by Jeremy Greenwood on 9/29/22.
//

import Foundation
#if canImport(CoreLocation)
import CoreLocation

extension CLLocation: LocationProtocol, @unchecked Sendable {
    public var latitude: Double { coordinate.latitude }
    public var longitude: Double { coordinate.longitude }
}
#endif

/// Defines the interface for a location
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public protocol LocationProtocol: Sendable {
    var latitude: Double { get }
    var longitude: Double { get }

    init(latitude: Double, longitude: Double)
}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct Location: LocationProtocol, Equatable, Codable, Sendable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
