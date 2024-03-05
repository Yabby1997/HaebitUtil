//
//  HaebitDateFormatterTests.swift
//  HaebitUtilTests
//
//  Created by Seunghun on 3/5/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import XCTest
@testable import HaebitUtil

final class HaebitDateFormatterTests: XCTestCase {
    private let dateFormatter = HaebitDateFormatter()
    private let enUS = Locale(identifier: "en-US")
    private let koKR = Locale(identifier: "ko-KR")
    
    func testToday() {
        let date = Date()
        XCTAssertEqual(dateFormatter.formatDate(from: date, with: enUS), "Today")
        XCTAssertEqual(dateFormatter.formatDate(from: date, with: koKR), "오늘")
    }
    
    func testYesterday() {
        let date = Date().addingTimeInterval(-24 * 60 * 60)
        XCTAssertEqual(dateFormatter.formatDate(from: date, with: enUS), "Yesterday")
        XCTAssertEqual(dateFormatter.formatDate(from: date, with: koKR), "어제")
    }
    
    func testInAWeekEnUS() {
        let expectedEnUS = Set(["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
        let actualEnUs = Set((0...30).map { day in
            let date = Date().addingTimeInterval(-Double(day) * 24 * 60 * 60)
            return dateFormatter.formatDate(from: date, with: enUS)
        })
        
        let expectedKoKR = Set(["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"])
        let actualKoKr = Set((0...30).map { day in
            let date = Date().addingTimeInterval(-Double(day) * 24 * 60 * 60)
            return dateFormatter.formatDate(from: date, with: koKR)
        })
            
        
        XCTAssertEqual(expectedEnUS.intersection(actualEnUs).count, 5)
        XCTAssertEqual(expectedKoKR.intersection(actualKoKr).count, 5)
    }
    
    func testThisYear() {
        let today = Date()
        let currentYear = Calendar.current.component(.year, from: today)

        guard let startOfYear = Calendar.current.date(from: DateComponents(year: currentYear, month: 1, day: 1)),
              let endOfYear = Calendar.current.date(from: DateComponents(year: currentYear, month: 12, day: 31)) else {
            XCTFail()
            return
        }
        
        XCTAssertFalse(dateFormatter.formatDate(from: today, with: enUS).contains(String(currentYear)))
        XCTAssertFalse(dateFormatter.formatDate(from: startOfYear, with: enUS).contains(String(currentYear)))
        XCTAssertFalse(dateFormatter.formatDate(from: endOfYear, with: enUS).contains(String(currentYear)))
        XCTAssertFalse(dateFormatter.formatDate(from: today, with: koKR).contains(String(currentYear)))
        XCTAssertFalse(dateFormatter.formatDate(from: startOfYear, with: koKR).contains(String(currentYear)))
        XCTAssertFalse(dateFormatter.formatDate(from: endOfYear, with: koKR).contains(String(currentYear)))
    }
    
    func testAnotherYear() {
        let today = Date()
        let currentYear = Calendar.current.component(.year, from: today)
        let nextYear = currentYear + 1
        let lastYear = currentYear - 1

        guard let startOfNextYear = Calendar.current.date(from: DateComponents(year: nextYear, month: 1, day: 1)),
              let endOfLastYear = Calendar.current.date(from: DateComponents(year: lastYear, month: 12, day: 31)) else {
            XCTFail()
            return
        }
        
        XCTAssertFalse(dateFormatter.formatDate(from: today, with: enUS).contains(String(currentYear)))
        XCTAssertTrue(dateFormatter.formatDate(from: startOfNextYear, with: enUS).contains(String(nextYear)))
        XCTAssertTrue(dateFormatter.formatDate(from: endOfLastYear, with: enUS).contains(String(lastYear)))
        XCTAssertFalse(dateFormatter.formatDate(from: today, with: koKR).contains(String(currentYear)))
        XCTAssertTrue(dateFormatter.formatDate(from: startOfNextYear, with: koKR).contains(String(nextYear)))
        XCTAssertTrue(dateFormatter.formatDate(from: endOfLastYear, with: koKR).contains(String(lastYear)))
    }
    
    func testTime() {
        for _ in 0...1000 {
            guard let randomHour = (0...23).randomElement(),
                  let randomMinute = (0...59).randomElement(),
                  let date = Calendar.current.date(from: DateComponents(year: 1, month: 1, day: 1, hour: randomHour, minute: randomMinute)) else {
                XCTFail()
                return
            }
            
            let expected = String(format: "%02d", randomHour) + ":" + String(format: "%02d", randomMinute)
            XCTAssertEqual(dateFormatter.formatTime(from: date, with: enUS), expected)
            XCTAssertEqual(dateFormatter.formatTime(from: date, with: koKR), expected)
        }
    }
}
