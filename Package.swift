// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "open-weather-kit",
    platforms: [
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "OpenWeatherKit",
            targets: ["OpenWeatherKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "OpenWeatherKit",
            dependencies: []),
        .testTarget(
            name: "OpenWeatherKitTests",
            dependencies: ["OpenWeatherKit"]),
    ]
)
