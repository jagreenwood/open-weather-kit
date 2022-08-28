import XCTest
@testable import OpenWeatherKit

final class OpenWeatherKitTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OpenWeatherKit().text, "Hello, World!")
    }
}
