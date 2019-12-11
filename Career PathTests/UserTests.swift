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
    
    func testUsername() {
        print("Test username")
        XCTAssertTrue(validPerson.username == "John")
    }
    
    func testEmail() {
        print("Test email")
        XCTAssertTrue(validPerson.email == "Smith")
    }
    
    func testPassword(){
        print("Test password")
        XCTAssertTrue(validPerson.password == "password")
    }
    
    func testUsername2() {
        print("Test username")
        XCTAssertTrue(invalidPerson.username == "Anonymous")
    }
    
    func testEmail2() {
        print("Test email")
        XCTAssertTrue(invalidPerson.email == "Anonymous")
    }
    
    func testPassword2(){
        print("Test password")
        XCTAssertFalse(invalidPerson.password == "")
    }
    
    func testEmptyArray() {
        print("Test array 1")
        XCTAssert(invalidPerson.testResults == [])
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
