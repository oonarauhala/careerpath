//
//  PersonalityTest_Tests.swift
//  Career PathTests
//
//  Created by iosdev on 24/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import XCTest
@testable import Career_Path

class PersonalityTest_Tests: XCTestCase {

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
    
    func testQuestionEmptiString() {
        let emptyStringQuestion = Question(text: "" , answers: [Answer(text: "Principles", type: .T), Answer(text: "Emotions", type: .F)])
        XCTAssert(emptyStringQuestion.text == "", "Question can't be empty")
    }
    
    func testAnswerEmptyString() {
        let emptyStringAnswer = Answer(text: "", type: .T)
        XCTAssert(emptyStringAnswer.text == "", "Answer can't be empty")
    }
    
}
