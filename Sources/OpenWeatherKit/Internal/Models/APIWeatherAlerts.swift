//
//  APIWeatherAlerts.swift
//  
//
//  Created by Jeremy Greenwood on 10/16/22.
//

import Foundation

// MARK: - APIWeatherAlerts
struct APIWeatherAlerts: Codable, Equatable {
    let name: String
    let metadata: APIMetadata
    let detailsURL: String
    let alerts: [String]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case metadata = "metadata"
        case detailsURL = "detailsUrl"
        case alerts = "alerts"
    }
}
