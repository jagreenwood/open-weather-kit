// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "open-weather-kit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .macOS(.v11),
        .visionOS(.v1)
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
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "OpenWeatherKitTests",
            dependencies: ["OpenWeatherKit"]),
    ]
)

#if os(Linux)
package.dependencies.append(.package(url: "https://github.com/swift-server/async-http-client.git", from: "1.19.0"))
package.targets.first { $0.name == "OpenWeatherKit" }?.dependencies.append(.product(name: "AsyncHTTPClient", package: "async-http-client"))
#endif


