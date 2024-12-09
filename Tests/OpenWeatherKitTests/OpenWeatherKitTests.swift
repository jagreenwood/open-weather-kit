import XCTest
@testable import OpenWeatherKit

final class OpenWeatherKitTests: XCTestCase {
#if canImport(CoreLocation)
    func testWeather() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set(MockClient.Include.allCases))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient,
            geocoder: .mock
        )

        let _ = try await service.weather(
            for: Location(
                latitude: 0,
                longitude: 0
            )
        )

        let _ = try await service.weather(
            for: Location(
                latitude: 0,
                longitude: 0
            ),
            countryCode: "US",
            language: .germanDE
        )
    }

    func testDataSet1() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([.daily]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient,
            geocoder: .mock
        )

        let _ = try await service.weather(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .daily)
    }

    func testDataSet2() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([.daily, .hourly]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient,
            geocoder: .mock
        )

        let _ = try await service.weather(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .daily, .hourly)
    }

    func testDataSet3() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([.daily, .hourly, .alerts]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient,
            geocoder: .mock
        )

        let _ = try await service.weather(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .daily, .hourly, .alerts)
    }

    func testDataSet3Optional() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([.daily, .hourly]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient,
            geocoder: .mock
        )

        do {
            let _ = try await service.weather(
                for: Location(
                    latitude: 0,
                    longitude: 0),
                including: .daily, .hourly, .alerts)
        } catch {
            switch error {
            case let weatherError as WeatherError where weatherError == .missingData(APIWeather.CodingKeys.weatherAlerts.rawValue):
                break
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
#else
    func testWeather() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set(MockClient.Include.allCases))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient
        )

        let _ = try await service.weather(
            for: Location(
                latitude: 0,
                longitude: 0
            ),
            countryCode: ""
        )
    }

    func testDataSet1() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([.daily]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient
        )

        let _ = try await service.weather(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .daily)
    }

    func testDataSet2() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([.daily, .hourly]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient
        )

        let _ = try await service.weather(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .daily, .hourly)
    }

    func testDataSet3() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([.daily, .hourly, .alerts]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient
        )

        let _ = try await service.weather(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .daily, .hourly, .alerts(countryCode: ""))
    }

    func testDataSet3Optional() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([.daily, .hourly]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient
        )

        do {
            let _ = try await service.weather(
                for: Location(
                    latitude: 0,
                    longitude: 0),
                including: .daily, .hourly, .alerts(countryCode: ""))
        } catch {
            switch error {
            case let weatherError as WeatherError where weatherError == .missingData(APIWeather.CodingKeys.weatherAlerts.rawValue):
                break
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
#endif
}
