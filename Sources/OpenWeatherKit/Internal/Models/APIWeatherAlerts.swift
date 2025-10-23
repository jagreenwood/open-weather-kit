//
//  APIWeatherAlerts.swift
//
//
//  Created by Jeremy Greenwood on 10/16/22.
//

import Foundation

// MARK: - APIWeatherAlerts
struct APIWeatherAlerts: Codable, Equatable {
    let metadata: APIMetadata
    let detailsURL: URL
    let alerts: [APIAlertSummary]

    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case detailsURL = "detailsUrl"
        case alerts = "alerts"
    }
}

struct APIAlertSummary: Codable, Equatable {
    @TextCaseCoding<Lowercased> var certainty: String
    @TextCaseCoding<Lowercased> var importance: String
    @TextCaseCoding<Lowercased> var severity: String
    @TextCaseCoding<Lowercased> var significance: String
    @TextCaseCoding<Lowercased> var urgency: String
    @TextCaseCoding<LowercasedArray> var responses: [String]
    let alertDescription: String
    let areaID: String?
    let areaName: String?
    let attributionURL: String
    let countryCode: String
    let detailsURL: URL
    let effectiveTime: Date
    let eventOnsetTime: Date
    let eventSource: String
    let expireTime: Date
    let id: String
    let issuedTime: Date
    let phenomenon: String
    let source: String
    let token: String

    enum CodingKeys: String, CodingKey {
        case alertDescription = "description"
        case areaID = "areaId"
        case areaName = "areaName"
        case attributionURL = "attributionUrl"
        case certainty = "certainty"
        case countryCode = "countryCode"
        case detailsURL = "detailsUrl"
        case effectiveTime = "effectiveTime"
        case eventOnsetTime = "eventOnsetTime"
        case eventSource = "eventSource"
        case expireTime = "expireTime"
        case id = "id"
        case importance = "importance"
        case issuedTime = "issuedTime"
        case phenomenon = "phenomenon"
        case responses = "responses"
        case severity = "severity"
        case significance = "significance"
        case source = "source"
        case token = "token"
        case urgency = "urgency"
    }

    init(
        alertDescription: String,
        areaID: String?,
        areaName: String?,
        attributionURL: String,
        certainty: String,
        countryCode: String,
        detailsURL: URL,
        effectiveTime: Date,
        eventOnsetTime: Date,
        eventSource: String,
        expireTime: Date,
        id: String,
        importance: String,
        issuedTime: Date,
        phenomenon: String,
        responses: [String],
        severity: String,
        significance: String,
        source: String,
        token: String,
        urgency: String
    ) {
        self.alertDescription = alertDescription
        self.areaID = areaID
        self.areaName = areaName
        self.attributionURL = attributionURL
        self.certainty = certainty
        self.countryCode = countryCode
        self.detailsURL = detailsURL
        self.effectiveTime = effectiveTime
        self.eventOnsetTime = eventOnsetTime
        self.eventSource = eventSource
        self.expireTime = expireTime
        self.id = id
        self.importance = importance
        self.issuedTime = issuedTime
        self.phenomenon = phenomenon
        self.responses = responses
        self.severity = severity
        self.significance = significance
        self.source = source
        self.token = token
        self.urgency = urgency
    }
}
