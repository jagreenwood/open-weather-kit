//
//  WeatherMetadata.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct WeatherMetadata {

    /// The date of the weather data request.
    public var date: Date

    /// The time the weather data expires.
    public var expirationDate: Date

    /// The location of the request.
    public var location: Location

    init(with apiMetadata: APIMetadata) {
        self.date = apiMetadata.readTime
        self.expirationDate = apiMetadata.expireTime
        self.location = Location(latitude: apiMetadata.latitude, longitude: apiMetadata.longitude)
    }
}

extension WeatherMetadata: Codable {}
extension WeatherMetadata: Equatable {}
