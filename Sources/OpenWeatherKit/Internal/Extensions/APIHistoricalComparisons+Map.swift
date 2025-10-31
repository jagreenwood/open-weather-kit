//
//  APIHistoricalComparisons+Map.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/31/25.
//

import Foundation

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
extension APIHistoricalComparisons {
    var historicalComparisons: HistoricalComparisons {
        HistoricalComparisons(
            comparisons: comparisons.compactMap { $0.historicalComparison },
            metadata: metadata.weatherMetadata
        )
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
extension APIComparison {
    var historicalComparison: HistoricalComparison? {
        let deviation = Deviation(rawValue: deviation) ?? .normal

        switch conditionType {
        case .temperatureMax:
            let baseline = TrendBaseline<UnitTemperature>(
                kind: TrendBaseline.Kind(rawValue: baselineType) ?? .mean,
                value: Measurement(value: baselineValue, unit: UnitTemperature.celsius),
                startDate: baselineStartDate
            )
            
            let trend = Trend(
                baseline: baseline,
                currentValue: Measurement(value: currentValue, unit: UnitTemperature.celsius),
                deviation: deviation
            )
            return .highTemperature(trend)
            
        case .temperatureMin:
            let baseline = TrendBaseline<UnitTemperature>(
                kind: TrendBaseline.Kind(rawValue: baselineType) ?? .mean,
                value: Measurement(value: baselineValue, unit: UnitTemperature.celsius),
                startDate: baselineStartDate
            )
            let trend = Trend(
                baseline: baseline,
                currentValue: Measurement(value: currentValue, unit: UnitTemperature.celsius),
                deviation: deviation
            )
            return .lowTemperature(trend)
            
        case .precipitation:
            let baseline = TrendBaseline<UnitLength>(
                kind: TrendBaseline.Kind(rawValue: baselineType) ?? .mean,
                value: Measurement(value: baselineValue, unit: UnitLength.millimeters),
                startDate: baselineStartDate
            )
            let trend = Trend(
                baseline: baseline,
                currentValue: Measurement(value: currentValue, unit: UnitLength.millimeters),
                deviation: deviation
            )
            return .precipitationAmount(trend)
            
        case .snowfall:
            let baseline = TrendBaseline<UnitLength>(
                kind: TrendBaseline.Kind(rawValue: baselineType) ?? .mean,
                value: Measurement(value: baselineValue, unit: UnitLength.millimeters),
                startDate: baselineStartDate
            )
            let trend = Trend(
                baseline: baseline,
                currentValue: Measurement(value: currentValue, unit: UnitLength.millimeters),
                deviation: deviation
            )
            return .snowfallAmount(trend)
            
        case .unknown:
            return nil
        }
    }
}
