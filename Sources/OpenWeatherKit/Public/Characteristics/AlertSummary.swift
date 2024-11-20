//
//  AlertSummary.swift
//  
//
//  Created by Jeremy Greenwood on 10/26/22.
//

import Foundation

/// All information related to the weather alert
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct AlertSummary: Codable, Equatable, Sendable {
    public var name: String
    public var id: String
    public var areaID: String
    public var areaName: String?
    public var attributionURL: String
    public var countryCode: String
    public var alertDescription: String
    public var effectiveTime: Date
    public var expireTime: Date
    public var issuedTime: Date
    public var detailsURL: URL
    public var phenomenon: String
    public var severity: WeatherSeverity
    public var source: String
    public var eventSource: String
    public var urgency: AlertUrgency
    public var certainty: Certainty
    public var importance: String
    public var responses: [WeatherResponse]

    public init(
        name: String,
        id: String,
        areaID: String,
        areaName: String?,
        attributionURL: String,
        countryCode: String,
        alertDescription: String,
        effectiveTime: Date,
        expireTime: Date,
        issuedTime: Date,
        detailsURL: URL,
        phenomenon: String,
        severity: WeatherSeverity,
        source: String,
        eventSource: String,
        urgency: AlertUrgency,
        certainty: Certainty,
        importance: String,
        responses: [WeatherResponse]
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

public enum WeatherResponse: String, Codable, Equatable, Sendable {
    /// Take shelter in place.
    case shelter

    /// Relocate.
    case evacuate

    /// Make preparations.
    case prepare

    /// Execute a pre-planned activity.
    case execute

    /// Avoid the event.
    case avoid

    /// Monitor the situation.
    case monitor

    /// Assess the situation.
    case assess

    /// The event no longer poses a threat.
    case allClear

    /// No action recommended.
    case none
}
