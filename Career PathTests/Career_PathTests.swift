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
    
    func testCareerSeparate1() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 5, education: Degree.Master, personalityType: .ENTJ, demand: Demand.Medium)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$5")
    }
    
    func testCareerSeparate2() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 5000, education: Degree.Master, personalityType: .ENTJ, demand: Demand.Medium)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$5,000")
    }
    
    func testCareerSeparate3() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 50000, education: Degree.Master, personalityType: .ENTJ, demand: Demand.Medium)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$50,000")
    }
    
    func testCareerSeparate4() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 500000, education: Degree.Master, personalityType: .ENTJ, demand: Demand.Medium)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$500,000")
    }
    
    func testCareerSeparate5() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 5000000, education: Degree.Master, personalityType: .ENTJ, demand: Demand.Medium)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "$5,000,000")
    }
    
    func testCareerSeparate6() {
        let test = Career(careerName: "Chef", description: "This is a description", medianSalary: 5000000000, education: Degree.Master, personalityType: .ENTJ, demand: Demand.Medium)
        print(test.salaryToString)
        XCTAssert(test.salaryToString == "A ridiculous amount")
    }
    
    func testCalculateSuitability() {
        let career = Career(careerName: "Astronomer", description: "stars", medianSalary: 100000, education: Degree.Doctorate, personalityType: PersonalityType.ENFJ, demand: Demand.Low)
        var suitabilityBarValue: Float = 0
        let mostSuitable: Float = 4
        var isResults = false
        let resultComponents: TestResults = TestResults.init(user: User("walter", "white", 55), personalityType: PersonalityType.ENTJ, keywords: [TypeAndFrequency.init(type: PersonalType.E, frequency: 5),TypeAndFrequency.init(type: PersonalType.N, frequency: 5), TypeAndFrequency.init(type: PersonalType.T, frequency: 5), TypeAndFrequency.init(type: PersonalType.J, frequency: 5)])
        career.calculateSuitability(&suitabilityBarValue, mostSuitable, &isResults, resultComponents)
        
        // Comparing ENFJ to ENTJ -> should return 3 components matches -> components/mostSuitable(4 components)
        XCTAssert(suitabilityBarValue == 3/4)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 
}
