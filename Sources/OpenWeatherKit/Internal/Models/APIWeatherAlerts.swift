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
    let detailsURL: URL
    let alerts: [APIAlertSummary]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case metadata = "metadata"
        case detailsURL = "detailsUrl"
        case alerts = "alerts"
    }
}

struct APIAlertSummary: Codable, Equatable {
    let name: String
    let id: String
    let areaID: String?
    let areaName: String?
    let attributionURL: String
    let countryCode: String
    let alertDescription: String
    let effectiveTime: Date
    let expireTime: Date
    let issuedTime: Date
    let detailsURL: URL
    let phenomenon: String
    let severity: String
    let source: String
    let eventSource: String
    let urgency: String
    let certainty: String
    let importance: String
    let responses: [String]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case areaID = "areaId"
        case areaName = "areaName"
        case attributionURL = "attributionURL"
        case countryCode = "countryCode"
        case alertDescription = "description"
        case effectiveTime = "effectiveTime"
        case expireTime = "expireTime"
        case issuedTime = "issuedTime"
        case detailsURL = "detailsUrl"
        case phenomenon = "phenomenon"
        case severity = "severity"
        case source = "source"
        case eventSource = "eventSource"
        case urgency = "urgency"
        case certainty = "certainty"
        case importance = "importance"
        case responses = "responses"
    }

    init(
        name: String,
        id: String,
        areaID: String,
        areaName: String,
        attributionURL: String,
        countryCode: String,
        alertDescription: String,
        effectiveTime: Date,
        expireTime: Date,
        issuedTime: Date,
        detailsURL: URL,
        phenomenon: String,
        alertPrecedence: Int,
        severity: String,
        source: String,
        eventSource: String,
        urgency: String,
        certainty: String,
        importance: String,
        responses: [String]
    ) {
        self.name = name
        self.id = id
        self.areaID = areaID
        self.areaName = areaName
        self.attributionURL = attributionURL
        self.countryCode = countryCode
        self.alertDescription = alertDescription
        self.effectiveTime = effectiveTime
        self.expireTime = expireTime
        self.issuedTime = issuedTime
        self.detailsURL = detailsURL
        self.phenomenon = phenomenon
        self.severity = severity
        self.source = source
        self.eventSource = eventSource
        self.urgency = urgency
        self.certainty = certainty
        self.importance = importance
        self.responses = responses
    }
}
