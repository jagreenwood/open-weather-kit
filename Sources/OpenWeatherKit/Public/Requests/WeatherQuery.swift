//
//  WeatherQuery.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// A structure that encapsulates a generic weather dataset request.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct WeatherQuery<T> {
    @usableFromInline
    let queryType: QueryType

    @usableFromInline
    let result: (WeatherProxy) throws -> T

    /// The current weather query.
    public static var current: WeatherQuery<CurrentWeather> {
        WeatherQuery<CurrentWeather>(
            queryType: .current(APIWeather.CodingKeys.currentWeather.rawValue),
            result: { try $0.currentWeather
                    .unwrap(or: WeatherError.missingData(APIWeather.CodingKeys.currentWeather.rawValue))
            }
        )
    }

    /// The minute forecast query.
    public static var minute: WeatherQuery<Forecast<MinuteWeather>?> {
        WeatherQuery<Forecast<MinuteWeather>?>(
            queryType: .minute(APIWeather.CodingKeys.forecastNextHour.rawValue),
            result: { try $0.minuteForecast
                    .unwrap(or: WeatherError.missingData(APIWeather.CodingKeys.forecastNextHour.rawValue))
            }
        )
    }

    /// The hourly forecast query.
    public static var hourly: WeatherQuery<Forecast<HourWeather>> {
        WeatherQuery<Forecast<HourWeather>>(
            queryType: .hourly(
                APIWeather.CodingKeys.forecastHourly.rawValue,
                Date(),
                Date.hoursFromNow(24)
            ),
            result: { try $0.hourlyForecast
                    .unwrap(or: WeatherError.missingData(APIWeather.CodingKeys.forecastHourly.rawValue))
            }
        )
    }

    /// The daily forecast query.
    public static var daily: WeatherQuery<Forecast<DayWeather>> {
        WeatherQuery<Forecast<DayWeather>>(
            queryType: .daily(
                APIWeather.CodingKeys.forecastDaily.rawValue,
                Date(),
                Date.daysFromNow(10)
            ),
            result: { try $0.dailyForecast
                    .unwrap(or: WeatherError.missingData(APIWeather.CodingKeys.forecastDaily.rawValue))
            }
        )
    }

#if canImport(CoreLocation)
    public static var alerts: WeatherQuery<[WeatherAlert]?> {
        WeatherQuery<[WeatherAlert]?>(
            queryType: .alerts(
                APIWeather.CodingKeys.weatherAlerts.rawValue, ""
            ),
            result: { try $0.weatherAlerts
                    .unwrap(or: WeatherError.missingData(APIWeather.CodingKeys.weatherAlerts.rawValue))
            }
        )
    }

    public static var availability: WeatherQuery<WeatherAvailability> {
        WeatherQuery<WeatherAvailability>(
            queryType: .availability(
                QueryContants.availability, ""
            ),
            result: { try $0.availability
                    .unwrap(or: WeatherError.missingData(QueryContants.availability))
            }
        )
    }
#endif
}

public extension WeatherQuery where T == Forecast<DayWeather> {
    /// The daily forecast query that takes a start date and end date for the request.
    static func daily(
        startDate: Date,
        endDate: Date
    ) -> WeatherQuery<T> {
        WeatherQuery<Forecast<DayWeather>>(
            queryType: .daily(
                APIWeather.CodingKeys.forecastDaily.rawValue,
                startDate,
                endDate
            ),
            result: { try $0.dailyForecast
                    .unwrap(or: WeatherError.missingData(APIWeather.CodingKeys.forecastDaily.rawValue))
            }
        )
    }
}

public extension WeatherQuery where T == Forecast<HourWeather> {
    static func hourly(
        startDate: Date,
        endDate: Date
    ) -> WeatherQuery<T> {
        WeatherQuery<Forecast<HourWeather>>(
            queryType: .hourly(
                APIWeather.CodingKeys.forecastHourly.rawValue,
                startDate,
                endDate
            ),
            result: { try $0.hourlyForecast
                    .unwrap(or: WeatherError.missingData(APIWeather.CodingKeys.forecastHourly.rawValue))
            }
        )
    }
}

public extension WeatherQuery where T == [WeatherAlert]? {
    /// The weather alerts query.
    static func alerts(countryCode: String) -> WeatherQuery<T> {
        WeatherQuery<[WeatherAlert]?>(
            queryType: .alerts(
                APIWeather.CodingKeys.weatherAlerts.rawValue,
                countryCode
            ),
            result: { try $0.weatherAlerts
                    .unwrap(or: WeatherError.missingData(APIWeather.CodingKeys.weatherAlerts.rawValue))
            }
        )
    }
}

public extension WeatherQuery where T == WeatherAvailability {
    /// The availability query.
    static func availability(countryCode: String) -> WeatherQuery<WeatherAvailability> {
        WeatherQuery<WeatherAvailability>(
            queryType: .availability(
                QueryContants.availability,
                countryCode
            ),
            result: { try $0.availability
                    .unwrap(or: WeatherError.missingData(QueryContants.availability))
            }
        )
    }
}

extension WeatherQuery {
    @usableFromInline
    func update(with countryCode: String) -> WeatherQuery {
        switch queryType {
        case let .alerts(dataSet, _):
            return WeatherQuery(
                queryType: .alerts(
                    dataSet,
                    countryCode),
                result: result
            )
        case let .availability(dataSet, _):
            return WeatherQuery(
                queryType: .availability(
                    dataSet,
                    countryCode),
                result: result
            )
        default: return self
        }
    }
}
