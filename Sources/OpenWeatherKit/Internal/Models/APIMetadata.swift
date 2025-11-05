//
//  APIMetadata.swift
//
//
//  Created by Jeremy Greenwood on 9/4/22.
//

import Foundation

// MARK: - APIMetadata
struct APIMetadata: Codable, Equatable {
    @TextCaseCoding<Lowercased> var sourceType: String
    let attributionURL: String?
    let expireTime: Date
    let language: String?
    let latitude: Double
    let longitude: Double
    let providerName: String?
    let readTime: Date
    let reportedTime: Date?
    let temporarilyUnavailable: Bool

    enum CodingKeys: String, CodingKey {
        case attributionURL = "attributionUrl"
        case expireTime = "expireTime"
        case language = "language"
        case latitude = "latitude"
        case longitude = "longitude"
        case providerName = "providerName"
        case readTime = "readTime"
        case reportedTime = "reportedTime"
        case sourceType = "sourceType"
        case temporarilyUnavailable = "temporarilyUnavailable"
    }
}
