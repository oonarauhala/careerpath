//
//  Career.swift
//  CareerPath
//
//  Created by mikael on 18/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation

// The main Career object that is used in everything career-related

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
    
    // -> Calculates the career suitability (only relevant in test results)
    func calculateSuitability(_ suitabilityBarValue: inout Float, _ mostSuitable: Float, _ isResults: inout Bool, _ resultComponents: TestResults) {
        // personalityType.getComponents() splits the personality type into its singular components
        let currentComponents = self.personalityType.getComponents()
        var suitability = 0
        // the test results have a property for the specified personality type,
        // so comparing every career's personality type to its components
        for keyword in resultComponents.personalityType.getComponents() {
            for component in currentComponents {
                if keyword == component {
                    suitability += 1 // <--- +1 point in suitability if a component matches
                }
            }
        }
        print("Career: \(self.careerName) Suitability: \(suitability) PersonalityType: \(self.personalityType)")
        
        suitabilityBarValue = Float(suitability) / mostSuitable
        isResults = true
    }
}
