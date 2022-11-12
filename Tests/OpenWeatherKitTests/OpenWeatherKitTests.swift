import XCTest
@testable import OpenWeatherKit

final class OpenWeatherKitTests: XCTestCase {
    func testWeather() async throws {
        let networkClient = NetworkClient(
            client: MockClient(include: Set(MockClient.Include.allCases))
        )

        let service = WeatherService(
            configuration: .init(jwt: {""}),
            networkClient: networkClient
        )

        let weather = try await service.weather(
            for: Location(latitude: 0,
            longitude: 0),
            countryCode: ""
        )
    }
}
