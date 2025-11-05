# OpenWeatherKit Example App

This is a SwiftUI example application demonstrating all public API methods available in OpenWeatherKit.

## Features

- **18 Weather Methods Demonstrated**: All forecast, statistics, and summary methods
- **Organized UI**: Methods grouped by category (Forecast, Statistics, Summary)
- **Comprehensive Results**: Custom formatting views for each data type
- **Error Handling**: User-friendly error messages with retry capability
- **Educational Comments**: Code includes explanations for learning purposes

## Setup Instructions

### 1. Add Files to Xcode Project

The Swift files have been created but need to be added to the Xcode project:

1. Open `OpenWeatherKitExample.xcodeproj` in Xcode
2. Right-click on the `OpenWeatherKitExample` folder in the Project Navigator
3. Select "Add Files to 'OpenWeatherKitExample'..."
4. Navigate to the following folders and add them with "Create folder references":
   - `Models/` (contains WeatherMethodType.swift and WeatherMethodResult.swift)
   - `ViewModels/` (contains WeatherViewModel.swift)
   - `Views/` (contains MethodListView.swift and MethodDetailView.swift)
   - `Views/Components/` (contains 6 formatting views)

### 2. Verify Project Configuration

- **Deployment Target**: Ensure minimum deployment target is set to iOS 18.0
  - Select the project in Project Navigator
  - Go to Build Settings
  - Search for "Deployment Target"
  - Set to iOS 18.0 or later

- **Package Dependencies**: Ensure OpenWeatherKit is linked
  - Select the project in Project Navigator
  - Go to the "Package Dependencies" tab
  - OpenWeatherKit should be listed
  - If not, add it using File → Add Package Dependencies

### 3. Configure JWT Token

Before running the app, you must provide a valid Apple WeatherKit JWT token:

1. Open `ExampleApp.swift`
2. Find the `createWeatherConfiguration()` method
3. Replace `"YOUR_JWT_TOKEN_HERE"` with your JWT generation code

#### Getting a WeatherKit JWT

You need:
- An Apple Developer account
- A WeatherKit service identifier (created in Apple Developer Portal)
- A private key downloaded from Apple Developer Portal

We recommend using [vapor/jwt-kit](https://github.com/vapor/jwt-kit) for JWT generation.

**Example JWT generation code:**

```swift
import JWTKit

let signers = JWTSigners()
try! signers.use(.es256(key: .private(pem: privateKeyPEM)))

struct WeatherKitJWT: JWTPayload {
    let iss: String  // Your Team ID
    let sub: String  // Your Service Identifier
    let exp: ExpirationClaim
    let iat: IssuedAtClaim

    func verify(using signer: JWTSigner) throws {
        try exp.verifyNotExpired()
    }
}

let payload = WeatherKitJWT(
    iss: "YOUR_TEAM_ID",
    sub: "YOUR_SERVICE_ID",
    exp: .init(value: Date().addingTimeInterval(3600)),
    iat: .init(value: Date())
)

return try! signers.sign(payload, kid: "YOUR_KEY_ID")
```

For more information, see [Apple's WeatherKit documentation](https://developer.apple.com/documentation/weatherkit).

### 4. Build and Run

1. Select a simulator or device (iOS 18.0+)
2. Press Cmd+R to build and run
3. Browse the list of weather methods
4. Tap any method to execute it and see results

## App Structure

```
OpenWeatherKitExample/
├── ExampleApp.swift           # App entry point with JWT configuration
├── Models/
│   ├── WeatherMethodType.swift    # Enum of all available methods
│   └── WeatherMethodResult.swift  # Result wrapper enum
├── ViewModels/
│   └── WeatherViewModel.swift     # Business logic for API calls
├── Views/
│   ├── MethodListView.swift       # Main list of methods
│   ├── MethodDetailView.swift     # Detail view with results
│   └── Components/
│       ├── CurrentWeatherView.swift   # Current conditions display
│       ├── ForecastView.swift         # Hourly/daily/minute forecasts
│       ├── WeatherAlertView.swift     # Alert display
│       ├── AvailabilityView.swift     # Dataset availability
│       ├── StatisticsView.swift       # Weather statistics
│       └── SummaryView.swift          # Weather summary
└── ContentView.swift          # Original placeholder (can be deleted)
```

## Demo Location

The app uses a hardcoded location for New York City:
- Latitude: 40.7128° N
- Longitude: 74.0060° W

This simplifies the demo by avoiding location permission requirements.

## Method Categories

### Forecast Methods (9)
- Full Weather (all datasets)
- Current Weather
- Minute Forecast (next hour)
- Hourly Forecast (24 hours)
- Daily Forecast (10 days)
- Weather Alerts
- Dataset Availability
- Weather Changes
- Historical Comparisons

### Statistics Methods (6)
- Daily Statistics (default range)
- Daily Statistics (custom date range)
- Hourly Statistics (current day)
- Hourly Statistics (custom date range)
- Monthly Statistics (all 12 months)
- Monthly Statistics (custom date range)

### Summary Methods (3)
- Daily Summary (past 30 days)
- Daily Summary (custom day range)
- Daily Summary (custom date interval)

## Troubleshooting

### Build Errors

If you see "No such module 'OpenWeatherKit'":
1. Ensure the OpenWeatherKit package is added to the project
2. Clean build folder (Cmd+Shift+K)
3. Rebuild (Cmd+B)

### API Errors

If all methods fail with authentication errors:
1. Verify your JWT token is valid
2. Check that your Team ID and Service ID are correct
3. Ensure your private key matches the Key ID in the JWT header
4. Verify the JWT hasn't expired

### SwiftLint Warnings

If SwiftLint is configured, you may see warnings. The code follows standard Swift conventions and can be auto-fixed with `swiftlint --fix`.

## License

This example app is provided as part of the OpenWeatherKit library for demonstration purposes.
