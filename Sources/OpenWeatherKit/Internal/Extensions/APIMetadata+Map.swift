//
//  APIMetadata+Map.swift
//  
//
//  Created by Jeremy Greenwood on 10/31/22.
//

@preconcurrency import Foundation

extension APIMetadata {
    var weatherMetadata: WeatherMetadata {
        WeatherMetadata(
            date: readTime,
            expirationDate: expireTime,
            location: Location(latitude: latitude, longitude: longitude)
        )
    }
}
