//
//  OpenWeatherKitExampleApp.swift
//  OpenWeatherKitExample
//
//  Created by Jeremy Greenwood on 11/4/25.
//

import SwiftUI
import OpenWeatherKit

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MethodListView(
                    viewModel: WeatherViewModel(
                        configuration: createWeatherConfiguration()
                    )
                )
            }
        }
    }

    /// Creates the WeatherService configuration with JWT provider
    ///
    /// IMPORTANT: You must provide your own valid Apple WeatherKit JWT token
    /// to use this example app. The placeholder below will cause API calls to fail.
    ///
    /// To get started with Apple WeatherKit:
    /// 1. Sign up for an Apple Developer account
    /// 2. Create a WeatherKit service identifier in the Apple Developer Portal
    /// 3. Generate a private key and download it
    /// 4. Use a JWT library (e.g., vapor/jwt-kit) to generate tokens
    ///
    /// Required JWT claims:
    /// - exp: Expiration time (usually ~1 hour from now)
    /// - iat: Issued at time (current time)
    /// - iss: Issuer (your Team ID)
    /// - sub: Subject (your WeatherKit Service Identifier)
    ///
    /// The JWT must be signed with ES256 using your private key and include
    /// the Key ID in the header.
    ///
    /// For more information, see Apple's WeatherKit documentation:
    /// https://developer.apple.com/documentation/weatherkit
    private func createWeatherConfiguration() -> WeatherService.Configuration {
        WeatherService.Configuration(
            jwt: {
                // REPLACE THIS WITH YOUR ACTUAL JWT GENERATION CODE
                // Example using jwt-kit (not included in this project):
                //
                // let signers = JWTSigners()
                // try! signers.use(.es256(key: .private(pem: privateKeyPEM)))
                // let payload = WeatherKitJWT(
                //     iss: "YOUR_TEAM_ID",
                //     sub: "YOUR_SERVICE_ID",
                //     exp: Date().addingTimeInterval(3600),
                //     iat: Date()
                // )
                // return try! signers.sign(payload, kid: "YOUR_KEY_ID")

                // Placeholder token - REPLACE THIS
                return "YOUR_JWT_TOKEN_HERE"
            },
            language: .englishUS
        )
    }
}
