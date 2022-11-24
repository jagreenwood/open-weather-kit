//
//  Geocoder+Mock.swift
//  
//
//  Created by Jeremy Greenwood on 11/17/22.
//

@testable import OpenWeatherKit
import Foundation

extension Geocoder {
    static var mock = Self(countryCode: { _ in "" })
}
