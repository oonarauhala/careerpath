//
//  Career.swift
//  CareerPath
//
//  Created by iosdev on 18/11/2019.
//  Copyright © 2019 Mikael Kuokkanen. All rights reserved.
//

import Foundation

struct Career {
    let futureDemand: Demand
    let careerName: String
    let description: String
    let medianSalary: Double
    let educationRequirement: Degree
    let personalityType: PersonalityType
    
    var salaryToString: String {
        return separateThousands(value: Int(medianSalary))
    }
    
    init(careerName: String, description: String, medianSalary: Double, education: Degree, personalityType: PersonalityType, demand: Demand) {
        self.careerName = careerName
        self.description = description
        self.medianSalary = medianSalary
        self.educationRequirement = education
        self.personalityType = personalityType
        self.futureDemand = demand
        print("Career \(careerName) initialized")
    }
    
    func separateThousands(value: Int) -> String {
        let mutableString = NSMutableString(string: String(value))
        let length = String(value).count
        
        switch length {
        case 7:
            mutableString.insert(",", at: 4)
            mutableString.insert(",", at: 1)
        case 6:
            mutableString.insert(",", at: 3)
        case 5:
            mutableString.insert(",", at: 2)
        case 4:
            mutableString.insert(",", at: 1)
        default:
            return "A ridiculous amount"
        }
        return String("$\(mutableString)")
    }
}
