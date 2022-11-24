//
//  Geocoder+Mock.swift
//  
//
//  Created by Jeremy Greenwood on 11/17/22.
//

@testable import OpenWeatherKit
import Foundation

#if canImport(CoreLocation)
extension Geocoder {
    static var mock = Self(countryCode: { _ in "" })
}
#endif
