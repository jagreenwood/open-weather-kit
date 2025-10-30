//
//  WeatherService.swift
//
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation
#if os(Linux)
import AsyncHTTPClient
import NIOCore
#endif
#if canImport(CoreLocation)
import CoreLocation
#endif

/// Provides an interface for obtaining weather data.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
final public class WeatherService: Sendable {

    /// Establishes the configuration for weather requests.
    @available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
    public struct Configuration: Sendable {

        public enum Language: String, Sendable {
            case englishUS = "en_US"
            case germanDE = "de_DE"
        }

        public var jwt: @Sendable () -> String
        public var language: Language

        /// Initializes an instance of Configuation
        /// - Parameters:
        ///   - jwt: A closure to provide a JWT.
        ///   - language: A language to localize human readable strings.
        public init(
            jwt: @escaping @Sendable () -> String,
            language: WeatherService.Configuration.Language = .englishUS
        ) {
            self.jwt = jwt
            self.language = language
        }
    }

    @usableFromInline
    let configuration: Configuration

    @usableFromInline
    let networkClient: NetworkClient

#if canImport(CoreLocation)
    @usableFromInline
    let geocoder: Geocoder

    internal init(
        configuration: Configuration,
        networkClient: NetworkClient,
        geocoder: Geocoder
    ) {
        self.configuration = configuration
        self.networkClient = networkClient
        self.geocoder = geocoder
    }
#else
    internal init(
        configuration: Configuration,
        networkClient: NetworkClient
    ) {
        self.configuration = configuration
        self.networkClient = networkClient
    }
#endif

#if os(Linux)
    public init(configuration: Configuration) {
        self.configuration = configuration
        self.networkClient = NetworkClient(
            client: HTTPClient(eventLoopGroupProvider: .singleton)
        )
    }

    public func shutdown() async throws {
        try await networkClient.client.shutdown()
    }

#else
    public init(configuration: Configuration) {
        self.configuration = configuration
        self.networkClient = NetworkClient(
            client: URLSession.shared
        )
        self.geocoder = .live
    }
#endif

    /// The required attribution which includes a legal attribution page and Apple Weather mark.
    final public var attribution: WeatherAttribution {
        get {
            WeatherAttribution(
                serviceName: "Apple Weather",
                legalPageURL: URL(string: "https://weather-data.apple.com/legal-attribution.html")!,
                squareMarkURL: URL(string: "https://weather-data.apple.com/assets/branding/square-mark.png")!,
                combinedMarkDarkURL: URL(string: "https://weather-data.apple.com/assets/branding/combined-mark-dark.png")!,
                combinedMarkLightURL: URL(string: "https://weather-data.apple.com/assets/branding/combined-mark-light.png")!)
        }
    }
}
