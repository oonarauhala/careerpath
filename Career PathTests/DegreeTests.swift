//
//  DegreeTests.swift
//  Career PathTests
//
//  Created by iosdev on 24/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import XCTest
@testable import Career_Path

class DegreeTests: XCTestCase {

    func testRequiredDegreeBasic() {
        let degree = Degree.Basic
        XCTAssert(degree.requiredDegree() == nil)
    }
    func testRequiredDegreeBachelor() {
        let degree = Degree.Bachelor
        XCTAssert(degree.requiredDegree() == .Basic)
    }
    func testRequiredDegreeMaster() {
        let degree = Degree.Master
        XCTAssert(degree.requiredDegree() == .Bachelor)
    }
    func testRequiredDegreeLicentiate() {
        let degree = Degree.Licentiate
        XCTAssert(degree.requiredDegree() == .Bachelor)
    }
    func testRequiredDegreeDoctorate() {
        let degree = Degree.Doctorate
        XCTAssert(degree.requiredDegree() == .Master)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
