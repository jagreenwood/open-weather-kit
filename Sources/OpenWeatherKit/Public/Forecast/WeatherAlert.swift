//
//  WeatherAlert.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation
import WeatherKit

public struct WeatherAlert: Sendable {
    /// The site for more details about the weather alert. Required link for attribution.
    public var detailsURL: URL

    /// The current weather metadata.
    public var metadata: WeatherMetadata

    /// Detailed information about the weather alert.
    public var alert: AlertSummary
}

extension WeatherAlert: Codable {}
