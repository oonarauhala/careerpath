//
//  TestResults.swift
//  Career Path
//
//  Created by mikael on 02/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

// Model for test results

struct TestResults {
    var user: User?
    let personalityType: PersonalityType
    
    init(user: User? = nil, personalityType: PersonalityType) {
        self.user = user
        self.personalityType = personalityType
    }
}

struct TypeAndFrequency {
    let type: PersonalType
    let frequency: Int
}


