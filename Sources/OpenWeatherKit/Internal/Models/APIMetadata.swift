//
//  APIMetadata.swift
//  
//
//  Created by Jeremy Greenwood on 9/4/22.
//

import Foundation

// MARK: - APIMetadata
struct APIMetadata: Codable, Equatable {
    let attributionURL: String
    let expireTime: Date
    let latitude: Double
    let longitude: Double
    let readTime: Date
    let reportedTime: Date?
    let units: String?
    let version: Int
    let language: String?
    let providerName: String?

    enum CodingKeys: String, CodingKey {
        case attributionURL = "attributionURL"
        case expireTime = "expireTime"
        case latitude = "latitude"
        case longitude = "longitude"
        case readTime = "readTime"
        case reportedTime = "reportedTime"
        case units = "units"
        case version = "version"
        case language = "language"
        case providerName = "providerName"
    }
}
