//
//  Geocoder.swift
//  
//
//  Created by Jeremy Greenwood on 11/17/22.
//

import Foundation
#if canImport(CoreLocation)
import CoreLocation

@usableFromInline
struct Geocoder: Sendable {
    @usableFromInline
    var countryCode: @Sendable (LocationProtocol) async throws -> String?

    static var live: Self {
        let geocoder = CLGeocoder()
        return .init {
            try await geocoder.reverseGeocodeLocation(
                CLLocation(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
            ).first?.isoCountryCode
        }
    }
}
#endif
