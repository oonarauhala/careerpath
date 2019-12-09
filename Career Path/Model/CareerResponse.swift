//
//  CareerResponse.swift
//  Career Path
//
//  Created by mikael on 22/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation

// A Decodable struct that parses the JSON response from the
// JSON server and converts it into a Career

struct CareerResponse:Decodable {
    let name: String
    let description: String
    let salary: Int
    let degree: Int
    let personality: Int
    let futureDemand: Int
    
    func convertToCareer() -> Career {
        return Career(careerName: self.name, description: self.description, medianSalary: Double(self.salary), education: convertToDegree(intValue: self.degree), personalityType: convertToPersonalityType(intValue: self.personality), demand: Demand(rawValue: self.futureDemand) ?? Demand.Medium)
    }
    
    func convertToDegree(intValue: Int) -> Degree {
        switch intValue {
        case 0:
            return Degree.Basic
        case 1:
            return Degree.Bachelor
        case 2:
            return Degree.Master
        case 3:
            return Degree.Licentiate
        case 4:
            return Degree.Doctorate
        default:
            fatalError("Degree value not found from CareerResponse struct \(self.name)")
        }
    }
    
    func convertToPersonalityType(intValue: Int) -> PersonalityType {
        switch intValue {
        case 0:
            return PersonalityType.ISTJ
        case 1:
            return PersonalityType.ISFJ
        case 2:
            return PersonalityType.INFJ
        case 3:
            return PersonalityType.INTJ
        case 4:
            return PersonalityType.ISTP
        case 5:
            return PersonalityType.ISFP
        case 6:
            return PersonalityType.INFP
        case 7:
            return PersonalityType.INTP
        case 8:
            return PersonalityType.ESTP
        case 9:
            return PersonalityType.ESFP
        case 10:
            return PersonalityType.ENFP
        case 11:
            return PersonalityType.ENTP
        case 12:
            return PersonalityType.ESTJ
        case 13:
            return PersonalityType.ESFJ
        case 14:
            return PersonalityType.ENFJ
        case 15:
            return PersonalityType.ENTJ
        default:
            fatalError("Personality value missing or is incorrect in CareerResponse struct \(self.name) -> value: \(intValue)")
        }
    }
}
