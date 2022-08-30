//
//  WeatherMetadata.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation
import CoreLocation

public struct WeatherMetadata {

    /// The date of the weather data request.
    public var date: Date

    /// The time the weather data expires.
    public var expirationDate: Date

    /// The location of the request.
    public var location: CLLocation {
        fatalError("not implemented")
    }
}
