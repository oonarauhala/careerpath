//
//  CareerEntity+CoreDataClass.swift
//  Career Path
//
//  Created by mikael on 24/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CareerEntity)
public class CareerEntity: NSManagedObject {

    func convertToCareer() -> Career {
        return Career(careerName: self.name!, description: self.careerDescription ?? "Oops! Something went wrong...", medianSalary: self.salary, education: convertToDegree(intValue: Int(self.degree)), personalityType: convertToPersonalityType(intValue: Int(self.personalityType)), demand: Demand(rawValue: Int(self.demand)) ?? Demand.Medium)
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
            fatalError("Degree value not found from CareerResponse initialization for: \(String(describing: self.name))")
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
            fatalError("Personality value missing from CareerResponse initialization for: \(String(describing: self.name))")
        }
    }
}
