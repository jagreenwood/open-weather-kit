//
//  Location.swift
//  
//
//  Created by Jeremy Greenwood on 9/29/22.
//

import Foundation

public struct Location: Equatable, Codable, Sendable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
