//
//  DailyWeatherSummaryQuery.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// A structure that encapsulates a daily weather summary dataset request.
@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
public struct DailyWeatherSummaryQuery<T>: Sendable where T: Decodable, T: Encodable, T: Equatable, T: Sendable {
    @usableFromInline
    internal let statisticsType: StatisticsType

    @usableFromInline
    internal init(statisticsType: StatisticsType) {
        self.statisticsType = statisticsType
    }

    /// The temperature summary query.
    public static var temperature: DailyWeatherSummaryQuery<DayTemperatureSummary> {
        DailyWeatherSummaryQuery<DayTemperatureSummary>(statisticsType: .temperature)
    }

    /// The precipitation summary query.
    public static var precipitation: DailyWeatherSummaryQuery<DayPrecipitationSummary> {
        DailyWeatherSummaryQuery<DayPrecipitationSummary>(statisticsType: .precipitation)
    }
}
