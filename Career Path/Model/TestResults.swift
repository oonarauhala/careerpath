//
//  TestResults.swift
//  Career Path
//
//  Created by mikael on 02/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

struct TestResults {
    var user: User?
    let personalityType: PersonalityType
    // implement keywords to provide a more
    // detailed display of careers if time
//    var keywords: [TypeAndFrequency] = []
    
    init(user: User? = nil, personalityType: PersonalityType) {
        self.user = user
        self.personalityType = personalityType
//        self.keywords = keywords
    }
}

struct TypeAndFrequency {
    let type: PersonalType
    let frequency: Int
}


