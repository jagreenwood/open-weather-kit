# OpenWeatherKit

[![Linux Swift 5](https://github.com/jagreenwood/OpenWeatherKit/actions/workflows/swift-5.yml/badge.svg)](https://github.com/jagreenwood/OpenWeatherKit/actions?query=workflow%3Aswift-5)
[![Linux Swift 6](https://github.com/jagreenwood/OpenWeatherKit/actions/workflows/swift-6.yml/badge.svg)](https://github.com/jagreenwood/OpenWeatherKit/actions?query=workflow%3Aswift-6)
[![macOS](https://github.com/jagreenwood/OpenWeatherKit/actions/workflows/swift-macos.yml/badge.svg)](https://github.com/jagreenwood/OpenWeatherKit/actions?query=workflow%3Aswift-macos)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjagreenwood%2Fopen-weather-kit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/jagreenwood/open-weather-kit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjagreenwood%2Fopen-weather-kit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/jagreenwood/open-weather-kit)

This package is Swift wrapper around the [WeatherKit REST API](https://developer.apple.com/documentation/weatherkitrestapi).
Its intention is to bring a native Swift WeatherKit alternative to platforms Apple does not currently support. The API of this package
is nearly identical to Apple's [WeatherKit](https://developer.apple.com/documentation/weatherkit).

## 💻 Supported Platforms

- iOS 13+
- watchOS 6+
- tvOS 13+
- macOS 11+
- Ubuntu 18.04+

## ⚙️ Setup

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

    func verify(using signer: JWTKit.JWTSigner) throws {}
}
```

Generate the JWT

```swift
struct JWTProvider {
    static func generate() -> String {
        let signers = JWTSigners()
        try signers.use(.es256(key: ECDSAKey.private(pem: PRIVATE_KEY_FROM_DEV_PORTAL))

        let payload = Payload(
            expiration: .init(value: .distantFuture),
            issued: .init(value: .now),
            issuer: TEAM_ID,
            subject: SERVICE_IDENTIFIER
        )

        return try! signers.sign(payload, kid: KEY_ID)
    }
}
```

Note the variables:

`PRIVATE_KEY_FROM_DEV_PORTAL`: The contents of the private key file including `-----BEGIN PRIVATE KEY-----` and `-----END PRIVATE KEY-----`

`TEAM_ID`: Found in Membership Details on the developer portal

`SERVICE_IDENTIFIER`: The reverse-domain name noted earlier

`KEY_ID`: The ID of the service key

## 🌤️ Usage

### Initialize Service

The service must be initialized with a JWT generating closure and optionally a language.

```swift
let weatherService = WeatherService(
    configuration: .init(jwt: JWTProvider.generate)
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

### Geocoding for Country Code (Apple platforms only)

When the library is used on an Apple platform, the `countryCode` parameter is not required. Internally the library will use `CoreLocation` to reverse geocode the location to determine the country code. If the country cannot be determined, an error will be thrown.

## 📝 Attribution

Please be advised of [Apple's attribution guidelines](https://developer.apple.com/weatherkit/get-started/#attribution-requirements) when using this package.

Attribution information can be accessed with:

```swift
let attribution = weatherService.attribution
```

Note that this property returns a static `WeatherAttribution` instance using information from `WeatherKit` and is not guaranteed to be accurate or complete.
