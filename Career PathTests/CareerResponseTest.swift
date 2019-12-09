//
//  CareerResponseTest.swift
//  Career PathTests
//
//  Created by iosdev on 09/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import XCTest
@testable import Career_Path

class CareerResponseTest: XCTestCase {

    func testLegalConversions() {
        let personalityInt = 2
        let degreeInt = 2
        let testResponse = CareerResponse(name: "Name", description: "A very simple description", salary: 25000, degree: degreeInt, personality: personalityInt, futureDemand: 2)
        XCTAssert(testResponse.convertToCareer().personalityType.convertToInt() == personalityInt)
        XCTAssert(testResponse.convertToDegree(intValue: degreeInt) == Degree.Master)
        XCTAssert(testResponse.convertToPersonalityType(intValue: personalityInt).convertToInt() == personalityInt)
   
        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
