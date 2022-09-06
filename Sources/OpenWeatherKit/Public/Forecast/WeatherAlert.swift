//
//  WeatherAlert.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct WeatherAlert {

    /// The site for more details about the weather alert. Required link for attribution.
    public var detailsURL: URL

    /// The name of the source issuing the weather alert. Required to display for attribution.
    public var source: String

    /// The summary of the event type.
    ///
    /// The summary may or may not contain localized descriptions, depending on what is available from the source.
    public var summary: String

    /// The name of the affected area.
    public var region: String?

    /// The severity of the weather alert.
    public var severity: WeatherSeverity

    /// The current weather metadata.
    public var metadata: WeatherMetadata
}
