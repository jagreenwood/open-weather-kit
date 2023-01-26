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
- ``Precipitation``
- ``PressureTrend``
- ``UVIndex``
- ``WeatherCondition``
- ``WeatherSeverity``
- ``Wind``

### Forecast

- ``DayWeather``
- ``Forecast``
- ``HourWeather``
- ``MinuteWeather``
- ``WeatherAlert``
- ``WeatherAvailability``
- ``WeatherResponse``

### Requests

- ``CurrentWeather``
- ``WeatherAttribution``
- ``WeatherMetadata``
- ``WeatherQuery``

### Geographic Location

- ``LocationProtocol``
- ``Location``
