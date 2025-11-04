//
//  DailyWeatherStatisticsQuery.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// A structure that encapsulates a daily weather statistics dataset request.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
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
