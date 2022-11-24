//
//  WeatherQuery.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public struct WeatherQuery<T> {
    let queryType: QueryType
    let weatherKeyPath: KeyPath<WeatherProxy, T?>

    /// The current weather query.
    public static var current: WeatherQuery<CurrentWeather> {
        WeatherQuery<CurrentWeather>(
            queryType: .current(APIWeather.CodingKeys.currentWeather.rawValue),
            weatherKeyPath: \.currentWeather
        )
    }

    /// The minute forecast query.
    public static var minute: WeatherQuery<Forecast<MinuteWeather>?> {
        WeatherQuery<Forecast<MinuteWeather>?>(
            queryType: .minute(APIWeather.CodingKeys.forecastNextHour.rawValue),
            weatherKeyPath: \.minuteForecast?
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
            weatherKeyPath: \.hourlyForecast
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
            weatherKeyPath: \.dailyForecast
        )
    }

#if canImport(CoreLocation)
    public static var alerts: WeatherQuery<[WeatherAlert]?> {
        WeatherQuery<[WeatherAlert]?>(
            queryType: .availability(
                APIWeather.CodingKeys.weatherAlerts.rawValue, ""
            ),
            weatherKeyPath: \.weatherAlerts?
        )
    }

    public static var availability: WeatherQuery<WeatherAvailability> {
        WeatherQuery<WeatherAvailability>(
            queryType: .availability(
                QueryContants.availability, ""
            ),
            weatherKeyPath: \.availability)
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
            weatherKeyPath: \.dailyForecast
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
            weatherKeyPath: \.hourlyForecast
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
            weatherKeyPath: \.weatherAlerts?
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
            weatherKeyPath: \.availability)
    }
}

extension WeatherQuery {
    func update(with countryCode: String) -> WeatherQuery {
        switch queryType {
        case let .alerts(dataSet, _):
            return WeatherQuery(
                queryType: .alerts(
                    dataSet,
                    countryCode),
                weatherKeyPath: weatherKeyPath
            )
        case let .availability(dataSet, _):
            return WeatherQuery(
                queryType: .availability(
                    dataSet,
                    countryCode),
                weatherKeyPath: weatherKeyPath
            )
        default: return self
        }
    }
}
