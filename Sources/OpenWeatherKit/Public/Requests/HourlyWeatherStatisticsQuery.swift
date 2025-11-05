//
//  HourlyWeatherStatisticsQuery.swift
//
//
//  Created by Jeremy Greenwood on 10/29/25.
//

import Foundation

/// A structure that encapsulates an hourly weather statistics dataset request.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct HourlyWeatherStatisticsQuery<T>: Sendable where T: Decodable, T: Encodable, T: Equatable, T: Sendable {
    @usableFromInline
    internal let statisticsType: StatisticsType

    @usableFromInline
    internal init(statisticsType: StatisticsType) {
        self.statisticsType = statisticsType
    }

    /// The hourly temperature statistics query.
    public static var temperature: HourlyWeatherStatisticsQuery<HourTemperatureStatistics> {
        HourlyWeatherStatisticsQuery<HourTemperatureStatistics>(statisticsType: .temperature)
    }
}
