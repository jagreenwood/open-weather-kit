# GettingStarted

This is a quick start guide to help get set up and start getting weather data from Apple.

## Overview

The REST API requires a signed JWT to be sent with each request. To set this up you need:

- A paid developer account
- A Service Identifier
- A key

### Apple Developer Portal Setup

#### App Identifier

1. Go to [Identifiers](https://developer.apple.com/account/resources/identifiers/list)
2. On the top left, click the add button (+), select Services IDs, then click Continue.
3. Register a Service ID.
4. Make note of the Identifier (you'll need it later)
5. Click Continue, review the registration information, and click Register.

#### Key

1. Go to [Keys](https://developer.apple.com/account/resources/authkeys/list)
2. On the top left, click the add button (+)
3. Give your key a name, tick the "WeatherKit" box
4. Click Continue, review the registration information, and click Register.
5. Make note of the Key ID (you'll need it later)
6. Download the private key

### JWT

The WeatherKit REST API requires a JSON Web Token (JWT) to be sent with every request. Implementing the
logic necessary to generate a JWT is beyond the scope of the OpenWeatherKit project at this time.
For general information on JWT please visit https://jwt.io

That being said, the recommended package to handle this task is Vapor's [jwt-kit](https://github.com/vapor/jwt-kit). Here is how to set that up:

Implement model conforming to `JWTPayload`

```swift
import JWTKit

struct Payload: JWTPayload, Equatable {
    enum CodingKeys: String, CodingKey {
        case expiration = "exp"
        case issued = "iat"
        case issuer = "iss"
        case subject = "sub"
    }

    let expiration: ExpirationClaim
    let issued: IssuedAtClaim
    let issuer: IssuerClaim
    let subject: SubjectClaim

    func verify(using key: some JWTAlgorithm) throws {}
}
```

Generate the JWT

```swift
struct JWTProvider {
    static func generate() async throws -> String {
        let keys = JWTKeyCollection()
        try await keys.add(ecdsa: ES256PrivateKey(pem: PRIVATE_KEY_FROM_DEV_PORTAL))

        let payload = Payload(
            expiration: .init(value: .distantFuture),
            issued: .init(value: .now),
            issuer: TEAM_ID,
            subject: SERVICE_IDENTIFIER
        )

        return try await keys.sign(payload, kid: KEY_ID)
    }
}
```

Note the variables:

`PRIVATE_KEY_FROM_DEV_PORTAL`: The contents of the private key file including
`-----BEGIN PRIVATE KEY-----` and `-----END PRIVATE KEY-----`

`TEAM_ID`: Found in Membership Details on the developer portal

`SERVICE_IDENTIFIER`: The reverse-domain name noted earlier

`KEY_ID`: The ID of the service key

## Usage

### Initialize Service

The service must be initialized with a JWT generating closure and optionally a language.

```swift
let weatherService = WeatherService(
    configuration: .init(jwt: { try await JWTProvider.generate() })
)
```

### Get a Full Weather Forecast

```swift
let weather = try await weatherService
    .weather(
        for: Location(
            latitude: 37.541290,
            longitude: -77.511429),
        countryCode: "US"
    )
```

### Get a Partial Weather Forecast

```swift
let (dailyForecast, hourlyForecast, alerts) = try await weatherService
    .weather(
        for: Location(
            latitude: 37.541290,
            longitude: -77.511429),
        including: .daily, .hourly, .alerts(countryCode: "US")
    )
```

### Get Availability

Note that minute forecasts and alerts are not always available in all regions. Use the `.availability` query check their availability.

```swift
let availability = try await weatherService
    .weather(
        for: Location(
            latitude: 37.541290,
            longitude: -77.511429),
        including: .availability
    )
```

### Get Weather Statistics

Historical weather statistics are derived from weather data recorded over the past decades. Statistics are available at daily, hourly, and monthly intervals.

**Daily Statistics** (30 days ago to 10 days from now by default):

```swift
let (dailyPrecipitation, dailyTemperature) = try await weatherService
    .dailyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        including: .precipitation, .temperature
    )
```

**Daily Statistics** (specific day range, 1-366):

```swift
let (dailyPrecipitation, dailyTemperature) = try await weatherService
    .dailyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        startDay: 1,
        endDay: 10,
        including: .precipitation, .temperature
    )
```

**Hourly Statistics** (24 hours of current day by default):

```swift
let hourlyTemperature = try await weatherService
    .hourlyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        including: .temperature
    )
```

**Hourly Statistics** (specific hour range, 1-8784):

```swift
let hourlyTemperature = try await weatherService
    .hourlyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        startHour: 1,
        endHour: 24,
        including: .temperature
    )
```

**Monthly Statistics** (all 12 months by default):

```swift
let (monthlyPrecipitation, monthlyTemperature) = try await weatherService
    .monthlyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        including: .precipitation, .temperature
    )
```

**Monthly Statistics** (specific month range, 1-12):

```swift
let (monthlyPrecipitation, monthlyTemperature) = try await weatherService
    .monthlyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        startMonth: 1,
        endMonth: 6,
        including: .precipitation, .temperature
    )
```

### Get Weather Summaries

Weather summaries provide aggregated actual weather data (not statistics) for past dates.

**Daily Summary** (past 30 days by default):

```swift
let (dailyPrecipitation, dailyTemperature) = try await weatherService
    .dailySummary(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        including: .precipitation, .temperature
    )
```

**Daily Summary** (specific day range, 1-366):

```swift
let (dailyPrecipitation, dailyTemperature) = try await weatherService
    .dailySummary(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        startDay: 1,
        endDay: 10,
        including: .precipitation, .temperature
    )
```

**Daily Summary** (specific date interval):

```swift
let interval = DateInterval(start: startDate, end: endDate)
let (dailyPrecipitation, dailyTemperature) = try await weatherService
    .dailySummary(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        forDaysIn: interval,
        including: .precipitation, .temperature
    )
```

### Geocoding for Country Code (Apple platforms only)

When the library is used on an Apple platform, the `countryCode` and `timezone` parameters are not required. Internally, the library will use `CoreLocation` to reverse geocode the location to determine the country code. If the country cannot be determined, an error will be thrown.

## Attribution

Please be advised of [Apple's attribution guidelines](https://developer.apple.com/weatherkit/get-started/#attribution-requirements) when using this package.

Attribution information can be accessed with:

```swift
let attribution = weatherService.attribution
```

Note that this property returns a static `WeatherAttribution` instance using information from `WeatherKit` and is not guaranteed to be accurate or complete.
