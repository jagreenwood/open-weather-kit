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
    static let mock = Self(countryCode: { _ in "" })
}
#endif
