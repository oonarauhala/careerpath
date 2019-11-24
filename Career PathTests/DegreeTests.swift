//
//  DegreeTests.swift
//  Career PathTests
//
//  Created by iosdev on 24/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//
//  Are these tests useful? Probably need more implementation using
//  enums, to test stuff

import XCTest
@testable import Career_Path

class DegreeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCaseDoc() {
        let test = Degree.Doctorate.rawValue
        XCTAssert(test == """
            A doctorate (from Latin docere, "to teach") or doctor's degree (from Latin doctor, "teacher") or doctoral degree, is an academic degree awarded by universities, derived from the ancient formalism licentia docendi ("licence to teach"). In most countries, it is a research degree that qualifies the holder to teach at university level in the degree's field, or to work in a specific profession. There are a number of doctoral degrees; the most common is the Doctor of Philosophy (PhD), which is awarded in many different fields, ranging from the humanities to scientific disciplines.
            
            In the United States and some other countries, there are also some types of technical or professional degrees that include doctor in their name and are, in some of those countries, classified as doctorates. Professional doctorates historically came about to meet the needs of practitioners in a variety of disciplines. However, the necessity of these degrees may vary greatly across disciplines, making their significance unclear.
        """)
    }
    
    func testCaseMaster() {
        let test = Degree.Master
        XCTAssert(test.rawValue == """
            A doctorate (from Latin docere, "to teach") or doctor's degree (from Latin doctor, "teacher") or doctoral degree, is an academic degree awarded by universities, derived from the ancient formalism licentia docendi ("licence to teach"). In most countries, it is a research degree that qualifies the holder to teach at university level in the degree's field, or to work in a specific profession. There are a number of doctoral degrees; the most common is the Doctor of Philosophy (PhD), which is awarded in many different fields, ranging from the humanities to scientific disciplines.
            
            In the United States and some other countries, there are also some types of technical or professional degrees that include doctor in their name and are, in some of those countries, classified as doctorates. Professional doctorates historically came about to meet the needs of practitioners in a variety of disciplines. However, the necessity of these degrees may vary greatly across disciplines, making their significance unclear.
            """)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
