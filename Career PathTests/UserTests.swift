//
//  UserTests.swift
//  Career PathTests
//
//  Created by iosdev on 23/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import XCTest
@testable import Career_Path

class UserTests: XCTestCase {

    var validPerson = User("John", "Smith", "password")
    var invalidPerson = User("", "", "")
    
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
    
    func testName() {
        print("Test name")
        XCTAssertTrue(validPerson.username == "John")
    }
    
    func testLastname() {
        print("Test name")
        XCTAssertTrue(validPerson.email == "Smith")
    }
    
    func testAge(){
        print("Test age")
        XCTAssertTrue(validPerson.password == "password")
    }
    
    func testFirstname2() {
        print("Test name")
        XCTAssertTrue(invalidPerson.username == "Anonymous")
    }
    
    func testLastname2() {
        print("Test name")
        XCTAssertTrue(invalidPerson.email == "Anonymous")
    }
    
    func testAge2(){
        print("Test age")
        XCTAssertFalse(invalidPerson.password == "Anonymous")
    }
    
    func testAge3() {
        print("Test age 3")
        XCTAssert(invalidPerson.testResults == [])
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
