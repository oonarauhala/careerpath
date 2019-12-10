//
//  PersonalityTypeTests.swift
//  Career PathTests
//
//  Created by iosdev on 09/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import XCTest

class PersonalityTypeTests: XCTestCase {

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    // equality
    func testConvertToIntISTJ(){
        let testPersonalityType = PersonalityType.ISTJ
        XCTAssert(testPersonalityType.convertToInt() == 0)
    }
    
    func testConvertToIntISFJ(){
        let testPersonalityType = PersonalityType.ISFJ
        XCTAssert(testPersonalityType.convertToInt() == 1)
    }
    
    func testConvertToIntINFJ(){
        let testPersonalityType = PersonalityType.INFJ
        XCTAssert(testPersonalityType.convertToInt() == 2)
    }
    
    func testConvertToIntINTJ(){
        let testPersonalityType = PersonalityType.INTJ
        XCTAssert(testPersonalityType.convertToInt() == 3)
    }
    
    func testConvertToIntISTP(){
        let testPersonalityType = PersonalityType.ISTP
        XCTAssert(testPersonalityType.convertToInt() == 4)
    }
    
    func testConvertToIntISFP(){
        let testPersonalityType = PersonalityType.ISFP
        XCTAssert(testPersonalityType.convertToInt() == 5)
    }
    
    func testConvertToIntINFP(){
        let testPersonalityType = PersonalityType.INFP
        XCTAssert(testPersonalityType.convertToInt() == 6)
    }
    
    func testConvertToIntINTP(){
        let testPersonalityType = PersonalityType.INTP
        XCTAssert(testPersonalityType.convertToInt() == 7)
    }
    
    func testConvertToIntESTP(){
        let testPersonalityType = PersonalityType.ESTP
        XCTAssert(testPersonalityType.convertToInt() == 8)
    }
    
    func testConvertToIntESFP(){
        let testPersonalityType = PersonalityType.ESFP
        XCTAssert(testPersonalityType.convertToInt() == 9)
    }
    
    func testConvertToIntENFP(){
        let testPersonalityType = PersonalityType.ENFP
        XCTAssert(testPersonalityType.convertToInt() == 10)
    }
    
    func testConvertToIntENTP(){
        let testPersonalityType = PersonalityType.ENTP
        XCTAssert(testPersonalityType.convertToInt() == 11)
    }
    
    func testConvertToIntESTJ(){
        let testPersonalityType = PersonalityType.ESTJ
        XCTAssert(testPersonalityType.convertToInt() == 12)
    }
    
    func testConvertToIntESFJ(){
        let testPersonalityType = PersonalityType.ESFJ
        XCTAssert(testPersonalityType.convertToInt() == 13)
    }
    
    func testConvertToIntENFJ(){
        let testPersonalityType = PersonalityType.ENFJ
        XCTAssert(testPersonalityType.convertToInt() == 14)
    }
    
    func testConvertToIntENTJ(){
        let testPersonalityType = PersonalityType.ENTJ
        XCTAssert(testPersonalityType.convertToInt() == 15)
    }
    

}
