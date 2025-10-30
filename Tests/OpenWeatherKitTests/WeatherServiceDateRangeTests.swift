//
//  WeatherServiceDateRangeTests.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 10/30/25.
//

import Testing
import Foundation
@testable import OpenWeatherKit

@Suite("WeatherService Date Range Computation Tests")
struct WeatherServiceDateRangeTests {
    
    /// Creates a UTC Gregorian calendar for testing
    private var utcCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }
    
    // MARK: - Normal Cases (No Wrap-Around)
    
    @Test("Normal case: start and end in same year")
    func testNormalCase() throws {
        let calendar = utcCalendar
        let referenceYear = 2024
        
        // January 15 to January 31
        let result = try Date.computeDateRange(
            startDay: 15,
            endDay: 31,
            calendar: calendar,
            referenceYear: referenceYear
        )
        
        let expectedStart = calendar.date(from: DateComponents(year: 2024, month: 1, day: 15))!
        let expectedEnd = calendar.date(from: DateComponents(year: 2024, month: 1, day: 31))!
        
        #expect(result.startDate == expectedStart)
        #expect(result.endDate == expectedEnd)
    }
    
    @Test("First and last day of year")
    func testFirstAndLastDay() throws {
        let calendar = utcCalendar
        let referenceYear = 2024
        
        // Day 1 to Day 365
        let result = try Date.computeDateRange(
            startDay: 1,
            endDay: 365,
            calendar: calendar,
            referenceYear: referenceYear
        )
        
        let expectedStart = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
        let expectedEnd = calendar.date(from: DateComponents(year: 2024, month: 12, day: 30))! // 2024 is leap year
        
        #expect(result.startDate == expectedStart)
        #expect(result.endDate == expectedEnd)
    }
    
    @Test("Same start and end day")
    func testSameDay() throws {
        let calendar = utcCalendar
        let referenceYear = 2024
        
        // Day 100 to Day 100
        let result = try Date.computeDateRange(
            startDay: 100,
            endDay: 100,
            calendar: calendar,
            referenceYear: referenceYear
        )
        
        let expectedDate = calendar.date(from: DateComponents(year: 2024, month: 4, day: 9))!
        
        #expect(result.startDate == expectedDate)
        #expect(result.endDate == expectedDate)
    }
    
    // MARK: - Wrap-Around Cases
    
    @Test("Wrap-around: December 31 to January 2")
    func testWrapAroundDecemberToJanuary() throws {
        let calendar = utcCalendar
        let referenceYear = 2025

        // Day 366 (Dec 31 in leap year) to Day 2 (Jan 2)
        let result = try Date.computeDateRange(
            startDay: 366,
            endDay: 2,
            calendar: calendar,
            referenceYear: referenceYear
        )
        
        let expectedStart = calendar.date(from: DateComponents(year: 2024, month: 12, day: 31))!
        let expectedEnd = calendar.date(from: DateComponents(year: 2025, month: 1, day: 2))!

        #expect(result.startDate == expectedStart)
        #expect(result.endDate == expectedEnd)
    }
    
    @Test("Wrap-around: Day 365 to Day 1")
    func testWrapAroundLastToFirst() throws {
        let calendar = utcCalendar
        let referenceYear = 2024
        
        // Day 365 to Day 1
        let result = try Date.computeDateRange(
            startDay: 365,
            endDay: 1,
            calendar: calendar,
            referenceYear: referenceYear
        )
        
        let expectedStart = calendar.date(from: DateComponents(year: 2023, month: 12, day: 31))! // 2023 is not leap year
        let expectedEnd = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
        
        #expect(result.startDate == expectedStart)
        #expect(result.endDate == expectedEnd)
    }
    
    @Test("Wrap-around: Mid-year to early year")
    func testWrapAroundMidToEarly() throws {
        let calendar = utcCalendar
        let referenceYear = 2024
        
        // Day 200 to Day 50
        let result = try Date.computeDateRange(
            startDay: 200,
            endDay: 50,
            calendar: calendar,
            referenceYear: referenceYear
        )
        
        let expectedStart = calendar.date(from: DateComponents(year: 2023, month: 7, day: 19))!
        let expectedEnd = calendar.date(from: DateComponents(year: 2024, month: 2, day: 19))!
        
        #expect(result.startDate == expectedStart)
        #expect(result.endDate == expectedEnd)
    }
    
    // MARK: - Leap Year Tests
    
    @Test("Leap year: Day 366 exists")
    func testLeapYearDay366() throws {
        let calendar = utcCalendar
        let referenceYear = 2024 // 2024 is a leap year
        
        // Day 366 (Dec 31) to Day 366 (same day)
        let result = try Date.computeDateRange(
            startDay: 366,
            endDay: 366,
            calendar: calendar,
            referenceYear: referenceYear
        )
        
        let expectedDate = calendar.date(from: DateComponents(year: 2024, month: 12, day: 31))!
        
        #expect(result.startDate == expectedDate)
        #expect(result.endDate == expectedDate)
    }
    
    @Test("Non-leap year: Day 366 should fail")
    func testNonLeapYearDay366() throws {
        let calendar = utcCalendar
        let referenceYear = 2023 // 2023 is not a leap year
        
        // Day 366 should not exist in 2023
        #expect(throws: WeatherError.self) {
            try Date.computeDateRange(
                startDay: 366,
                endDay: 366,
                calendar: calendar,
                referenceYear: referenceYear
            )
        }
    }
    
    @Test("Wrap-around with leap year boundary")
    func testWrapAroundLeapYearBoundary() throws {
        let calendar = utcCalendar
        let referenceYear = 2024 // 2024 is leap year, 2023 is not
        
        // Day 366 in 2023 (non-leap year) should fail
        #expect(throws: WeatherError.self) {
            try Date.computeDateRange(
                startDay: 366,
                endDay: 1,
                calendar: calendar,
                referenceYear: referenceYear
            )
        }
    }
    
    // MARK: - Edge Cases and Error Conditions
    
    @Test("Invalid day 0 should fail")
    func testInvalidDay0() throws {
        let calendar = utcCalendar
        let referenceYear = 2024
        
        #expect(throws: WeatherError.self) {
            try Date.computeDateRange(
                startDay: 0,
                endDay: 1,
                calendar: calendar,
                referenceYear: referenceYear
            )
        }
    }
    
    @Test("Invalid day 367 should fail")
    func testInvalidDay367() throws {
        let calendar = utcCalendar
        let referenceYear = 2024
        
        #expect(throws: WeatherError.self) {
            try Date.computeDateRange(
                startDay: 1,
                endDay: 367,
                calendar: calendar,
                referenceYear: referenceYear
            )
        }
    }
    
    @Test("Extreme past year should work")
    func testExtremePastYear() throws {
        let calendar = utcCalendar
        let referenceYear = 1000
        
        let result = try Date.computeDateRange(
            startDay: 1,
            endDay: 31,
            calendar: calendar,
            referenceYear: referenceYear
        )
        
        let expectedStart = calendar.date(from: DateComponents(year: 1000, month: 1, day: 1))!
        let expectedEnd = calendar.date(from: DateComponents(year: 1000, month: 1, day: 31))!
        
        #expect(result.startDate == expectedStart)
        #expect(result.endDate == expectedEnd)
    }
    
    @Test("Future year should work")
    func testFutureYear() throws {
        let calendar = utcCalendar
        let referenceYear = 2050
        
        let result = try Date.computeDateRange(
            startDay: 100,
            endDay: 200,
            calendar: calendar,
            referenceYear: referenceYear
        )
        
        let expectedStart = calendar.date(from: DateComponents(year: 2050, month: 4, day: 10))!
        let expectedEnd = calendar.date(from: DateComponents(year: 2050, month: 7, day: 19))!
        
        #expect(result.startDate == expectedStart)
        #expect(result.endDate == expectedEnd)
    }
    
    // MARK: - Timezone Verification
    
    @Test("Results should be in UTC timezone")
    func testUTCTimezone() throws {
        let calendar = utcCalendar
        let referenceYear = 2024
        
        let result = try Date.computeDateRange(
            startDay: 1,
            endDay: 2,
            calendar: calendar,
            referenceYear: referenceYear
        )
        
        // Verify the dates are interpreted in UTC
        let utcComponents1 = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: result.startDate)
        let utcComponents2 = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: result.endDate)
        
        #expect(utcComponents1.year == 2024)
        #expect(utcComponents1.month == 1)
        #expect(utcComponents1.day == 1)
        #expect(utcComponents1.hour == 0)
        #expect(utcComponents1.minute == 0)
        #expect(utcComponents1.second == 0)
        
        #expect(utcComponents2.year == 2024)
        #expect(utcComponents2.month == 1)
        #expect(utcComponents2.day == 2)
    }
}
