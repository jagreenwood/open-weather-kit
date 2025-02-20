//
//  WeatherAlert.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// A weather alert issued for the requested location by a governmental authority.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct WeatherAlert: Sendable {
    /// The site for more details about the weather alert. Required link for attribution.
    public var detailsURL: URL

    /// The current weather metadata.
    public var metadata: WeatherMetadata

    /// Detailed information about the weather alert.
    public var alert: AlertSummary
}

extension WeatherAlert: Codable {}
