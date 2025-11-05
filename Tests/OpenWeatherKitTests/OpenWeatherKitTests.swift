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
            timezone: TimeZone(secondsFromGMT: 0)!,
            language: .englishUS
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

    func testHourlyStatistics() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient,
            geocoder: .mock
        )

        let _ = try await service.hourlyStatistics(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .temperature)
    }

    func testDailyStatistics() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient,
            geocoder: .mock
        )

        let _ = try await service.dailyStatistics(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .temperature, .precipitation
        )
    }

    func testMonthlyStatistics() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient,
            geocoder: .mock
        )

        let _ = try await service.monthlyStatistics(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .temperature, .precipitation
        )
    }

    func testDailySummary() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient,
            geocoder: .mock
        )

        let _ = try await service.dailySummary(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .temperature, .precipitation
        )
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
            countryCode: "",
            timezone: TimeZone(secondsFromGMT: 0)!
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
            including: .daily,
            timezone: TimeZone(secondsFromGMT: 0)!
        )
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
            including: .daily, .hourly,
            timezone: TimeZone(secondsFromGMT: 0)!
        )
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
            including: .daily, .hourly, .alerts(countryCode: ""),
            timezone: TimeZone(secondsFromGMT: 0)!
        )
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
                including: .daily, .hourly, .alerts(countryCode: ""),
                timezone: TimeZone(secondsFromGMT: 0)!
            )
        } catch {
            switch error {
            case let weatherError as WeatherError where weatherError == .missingData(APIWeather.CodingKeys.weatherAlerts.rawValue):
                break
            default:
                XCTFail("Unexpected error: \(error)")
            }
        }
    }

    func testDailySummary() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient
        )

        let _ = try await service.dailySummary(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .temperature, .precipitation
        )
    }

    func testHourlyStatistics() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient
        )

        let _ = try await service.hourlyStatistics(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .temperature)
    }

    func testDailyStatistics() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient
        )

        let _ = try await service.dailyStatistics(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .temperature, .precipitation
        )
    }

    func testMonthlyStatistics() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set([]))
        )

        let service = WeatherService(
            configuration: .init(jwt: { "" }),
            networkClient: networkClient
        )

        let _ = try await service.monthlyStatistics(
            for: Location(
                latitude: 0,
                longitude: 0),
            including: .temperature, .precipitation
        )
    }
#endif
}

