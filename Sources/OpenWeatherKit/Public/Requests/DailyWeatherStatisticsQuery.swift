//
//  DailyWeatherStatisticsQuery.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// A structure that encapsulates a daily weather statistics dataset request.
@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
public struct DailyWeatherStatisticsQuery<T>: Sendable where T: Decodable, T: Encodable, T: Equatable, T: Sendable {
    @usableFromInline
    internal let statisticsType: StatisticsType

    @usableFromInline
    internal init(statisticsType: StatisticsType) {
        self.statisticsType = statisticsType
    }

    /// The daily temperature statistics query.
    public static var temperature: DailyWeatherStatisticsQuery<DayTemperatureStatistics> {
        DailyWeatherStatisticsQuery<DayTemperatureStatistics>(statisticsType: .temperature)
    }

    /// The daily precipitation statistics query.
    public static var precipitation: DailyWeatherStatisticsQuery<DayPrecipitationStatistics> {
        DailyWeatherStatisticsQuery<DayPrecipitationStatistics>(statisticsType: .precipitation)
    }
}
