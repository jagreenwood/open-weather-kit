# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

OpenWeatherKit is a Swift wrapper around the WeatherKit REST API, bringing native Swift WeatherKit functionality to platforms Apple doesn't currently support (particularly Linux). The API mirrors Apple's WeatherKit as closely as possible.

## Build and Test Commands

### Building
```bash
swift build
```

### Running Tests
```bash
swift test
```

### Running a Single Test
```bash
swift test --filter <TestClassName>.<testMethodName>
# Example: swift test --filter OpenWeatherKitTests.testWeather
```

### Platform-Specific Testing
The test suite has conditional compilation for Apple platforms vs Linux:
- Apple platforms: Tests include CoreLocation-based geocoding
- Linux: Tests require explicit countryCode and timezone parameters

## Architecture

### Core Request Flow

1. **WeatherService** (public API) - Entry point for all weather requests
   - Accepts `LocationProtocol` (latitude/longitude)
   - Variadic methods support 1-6 different `WeatherQuery<T>` datasets in a single call
   - On Apple platforms: automatically geocodes location to get country code and timezone
   - On Linux: requires explicit `countryCode` and `timezone` parameters

2. **NetworkClient** (internal) - HTTP layer
   - Builds URLs via `Route` enum
   - Handles JWT bearer token authentication
   - Uses `URLSession` on Apple platforms, `AsyncHTTPClient` on Linux
   - Fetches data in parallel using `TaskGroup` when multiple queries are requested
   - Returns `WeatherProxy` which aggregates partial results

3. **WeatherProxy** (internal) - Result aggregation
   - Container for all possible weather data types
   - Supports combining multiple partial proxies (for parallel fetches)
   - Maps from API models to public models

4. **WeatherQuery<T>** (public) - Type-safe dataset requests
   - Generic query structure with static factory methods (`.current`, `.daily`, `.hourly`, etc.)
   - Contains both the query type and a closure to extract results from `WeatherProxy`
   - Supports updating with country codes for alerts/availability queries

### Platform Differences

**Apple Platforms** (`#if canImport(CoreLocation)`):
- Use `URLSession` for networking
- Include `Geocoder` for automatic country code/timezone resolution
- Support simplified API without explicit country code

**Linux** (`#if os(Linux)`):
- Use `AsyncHTTPClient` from swift-server
- Require explicit `countryCode` and `timezone` on all requests
- `WeatherService` includes `shutdown()` method to clean up HTTP client

### Data Flow

```
API Response (APIWeather/APIForecastDaily/etc.)
    ↓ (via extension +Map.swift files)
WeatherProxy (aggregates partial results)
    ↓ (via WeatherQuery.result closure)
Public Models (CurrentWeather/Forecast<DayWeather>/etc.)
```

### Internal vs Public Separation

- **Internal/Models**: API response models prefixed with `API*` (e.g., `APIWeather`, `APICurrentWeather`)
- **Internal/Extensions**: Mapping logic from API models to public models (`+Map.swift` files)
- **Public**: User-facing types matching Apple's WeatherKit API

### Key Protocols

- **LocationProtocol**: Abstraction for any type with `latitude` and `longitude`
- **Client**: Protocol for HTTP clients (implemented by `URLSession` wrapper and `AsyncHTTPClient` wrapper)

## Testing

Tests use a `MockClient` that returns predefined JSON responses from `MockData`. The mock client:
- Accepts an `Include` set to control which datasets to return
- Simulates API responses without real network calls
- On Apple platforms, uses `Geocoder.mock` for testing geocoding

## Dependencies

- **Swift 5.9+** minimum
- **No dependencies** on Apple platforms (uses `URLSession`)
- **AsyncHTTPClient** dependency on Linux (conditionally added via `#if os(Linux)` in Package.swift)

## JWT Authentication

The library does NOT generate JWTs. Users must provide a closure that returns a valid JWT string when initializing `WeatherService.Configuration`. The README recommends using Vapor's `jwt-kit` for JWT generation.

Required JWT claims:
- `exp` (expiration)
- `iat` (issued at)
- `iss` (issuer - Team ID)
- `sub` (subject - Service Identifier)
- Must be signed with ES256 using the private key from Apple Developer Portal
- Must include Key ID in header

## API Endpoint Structure

Base URL: `https://weatherkit.apple.com`

- Weather: `/api/v2/weather/{language}/{latitude}/{longitude}?dataSets=...&timezone=...`
- Availability: `/api/v2/availability/{latitude}/{longitude}?country={countryCode}`

## Date Handling

- JSON responses use Unix epoch timestamps (`secondsSince1970`)
- JSONDecoder configured with `.dateDecodingStrategy = .secondsSince1970`
- Date extensions provide utilities like `.hoursFromNow(24)` and `.daysFromNow(10)`

## Coding Conventions

- `@usableFromInline` on internal types/methods that are called from `@inlinable` public APIs
- Extensive use of `@inlinable` on public API surface for performance
- Sendable conformance throughout for Swift 6 compatibility
- TextCaseCoding for snake_case/camelCase conversion between API and Swift

## SwiftLint Integration

### Automatic Linting Hook

This repository includes a PostToolUse hook that automatically runs SwiftLint when Claude Code edits Swift files. The hook:
- Runs after every Edit or Write operation on Swift files
- Automatically fixes correctable violations (trailing whitespace, formatting issues, etc.)
- Reports remaining violations back to Claude for resolution
- Only processes Swift files in `Sources/`, `Tests/`, or `Package.swift`
- Completes within 15 seconds (timeout protection)

### Setup Requirements

**Required:** SwiftLint 0.50.0 or later must be installed:
```bash
brew install swiftlint
```

**Activation:** Copy the example settings to enable the hook:
```bash
cp .claude/settings.example.json .claude/settings.local.json
```

The hook is configured in `.claude/settings.local.json` (gitignored for local flexibility).

### Hook Behavior

**When you edit a Swift file:**
1. Hook receives the file path from Claude Code
2. Validates the file is a Swift file in target directories
3. Runs `swiftlint --fix` to auto-correct violations
4. Runs `swiftlint lint` to check for remaining violations
5. If violations remain: Reports them to Claude with file:line:column references and blocks the edit
6. If no violations: Completes silently

**Example violation report:**
```
SwiftLint found 2 violation(s) in Sources/OpenWeatherKit/Public/Weather.swift:
Sources/OpenWeatherKit/Public/Weather.swift:42:1: warning: Line should be 200 characters or less (line_length)
Sources/OpenWeatherKit/Public/Weather.swift:55:10: error: Print statement must not be used (custom_rules)
```

### Performance Impact

- Adds approximately 0.2-0.6 seconds per Swift file edit
- Runs only on Swift files (non-Swift files pass through instantly)
- Timeout protection prevents indefinite blocking

### Disabling the Hook

To disable SwiftLint integration:
```bash
rm .claude/settings.local.json
```

Or comment out the hook configuration in the settings file.

### Missing SwiftLint

If SwiftLint is not installed, the hook will:
- Exit gracefully with a warning message
- NOT block edits
- Suggest installation with `brew install swiftlint`
