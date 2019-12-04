//
//  TestResults.swift
//  Career Path
//
//  Created by mikael on 02/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

struct TestResults {
    let user: User
    let personalityType: PersonalityType
    // implement keywords to provide a more
    // detailed display of careers if time
    let keywords = [TypeAndFrequency]()
    
    init(user: User, personalityType: PersonalityType) {
        self.user = user
        self.personalityType = personalityType
    }
}

struct TypeAndFrequency {
    let type: PersonalType
    let frequency: Int
}
