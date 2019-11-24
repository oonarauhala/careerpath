//
//  Career_PathTests.swift
//  Career PathTests
//
//  Created by iosdev on 20/11/2019.
//  Copyright © 2019 Mikael Kuokkanen. All rights reserved.
//
// Tests for Career.swift file.

import XCTest
@testable import Career_Path

class Career_PathTests: XCTestCase {

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
    
    //Follown # tests look at thousands separator woring correctly.
    func testCareerSeparate1() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 5, education: Degree.Master, personalityType: PersonalityType.ENTJ)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$5")
        
    }
    
    func testCareerSeparate2() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 5000, education: Degree.Master, personalityType: PersonalityType.ENTJ)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$5,000")
        
    }
    
    func testCareerSeparate3() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 50000, education: Degree.Master, personalityType: PersonalityType.ENTJ)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$50,000")
        
    }
    
    func testCareerSeparate4() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 500000, education: Degree.Master, personalityType: PersonalityType.ENTJ)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$500,000")
        
    }
    
    func testCareerSeparate5() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 5000000, education: Degree.Master, personalityType: PersonalityType.ENTJ)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$5,000,000")
        
    }
    
    func testCareerSeparate6() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 5000000000, education: Degree.Master, personalityType: PersonalityType.ENTJ)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "A ridiculous amount")
        
    }
    
    func testCareerSeparate7() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: -10000, education: Degree.Master, personalityType: PersonalityType.ENTJ)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$0")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
