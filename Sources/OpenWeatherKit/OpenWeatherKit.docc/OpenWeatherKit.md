# ``OpenWeatherKit``

An open implementation of Apple's WeatherKit Framework.

## Overview

This package is a Swift wrapper around the [WeatherKit REST API](https://developer.apple.com/documentation/weatherkitrestapi).
Its intention is to bring a native Swift WeatherKit alternative to platforms Apple does not currently support. The API of this package 
is nearly identical to Apple's [WeatherKit](https://developer.apple.com/documentation/weatherkit).

## Topics

### Getting Started

- <doc:GettingStarted>

### Essentials

- ``WeatherService``
- ``Weather``
- ``WeatherError``

### Celestial Types

- ``MoonEvents``
- ``MoonPhase``
- ``SunEvents``

### Weather Characteristics

- ``AlertSummary``
- ``AlertUrgency``
- ``Certainty``
- ``CloudCoverByAltitude``
- ``DayPartForecast``
- ``Precipitation``
- ``PrecipitationAmountByType``
- ``PressureTrend``
- ``SnowfallAmount``
- ``UVIndex``
- ``WeatherCondition``
- ``WeatherSeverity``
- ``Wind``

### Forecast

- ``DayWeather``
- ``Forecast``
- ``HistoricalComparisons``
- ``HourWeather``
- ``MinuteWeather``
- ``WeatherAlert``
- ``WeatherAvailability``
- ``WeatherChanges``
- ``WeatherResponse``

### Requests

- ``CurrentWeather``
- ``DailyWeatherStatisticsQuery``
- ``DailyWeatherSummaryQuery``
- ``HourlyWeatherStatisticsQuery``
- ``MonthlyWeatherStatisticsQuery``
- ``WeatherAttribution``
- ``WeatherMetadata``
- ``WeatherQuery``

### Statistics

- ``DailyWeatherStatistics``
- ``DayPrecipitationStatistics``
- ``DayTemperatureStatistics``
- ``HourlyWeatherStatistics``
- ``HourTemperatureStatistics``
- ``MonthlyWeatherStatistics``
- ``MonthPrecipitationStatistics``
- ``MonthTemperatureStatistics``
- ``Percentiles``

### Summary

- ``DailyWeatherSummary``
- ``DayPrecipitationSummary``
- ``DayTemperatureSummary``

### Geographic Location

- ``LocationProtocol``
- ``Location``
