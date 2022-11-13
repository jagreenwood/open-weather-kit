//
//  APIWeatherAlerts+Map.swift
//  
//
//  Created by Jeremy Greenwood on 10/26/22.
//

import Foundation

extension APIWeatherAlerts {
    var weatherAlerts: [WeatherAlert] {
        alerts.map {
            WeatherAlert(
                detailsURL: detailsURL,
                metadata: metadata.weatherMetadata,
                alert: $0.alertSummary
            )
        }
    }
}

extension APIAlertSummary {
    var alertSummary: AlertSummary {
        AlertSummary(
            name: name,
            id: id,
            areaID: areaID,
            areaName: areaName,
            attributionURL: attributionURL,
            countryCode: countryCode,
            alertDescription: alertDescription,
            effectiveTime: effectiveTime,
            expireTime: expireTime,
            issuedTime: expireTime,
            detailsURL: detailsURL,
            phenomenon: phenomenon,
            severity: WeatherSeverity(rawValue: severity) ?? .unknown,
            source: source,
            eventSource: eventSource,
            urgency: AlertUrgency(rawValue: urgency) ?? .unknown,
            certainty: Certainty(rawValue: certainty) ?? .unknown,
            importance: importance,
            responses: responses.compactMap(WeatherResponse.init(rawValue:))
        )
    }
}
