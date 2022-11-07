//
//  WeatherAttribution.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct WeatherAttribution {

    /// The weather data provider name.
    public var serviceName: String

    /// A link to the legal attribution page that contains copyright information
    /// about the weather data sources.
    public var legalPageURL: URL

    /// A URL for the square Apple Weather mark.
    public var squareMarkURL: URL

    /// A URL for the combined "<logo> Apple Weather" mark, in dark variant.
    public var combinedMarkDarkURL: URL

    /// A URL for the combined "<logo> Apple Weather" mark, in light variant.
    public var combinedMarkLightURL: URL
}
