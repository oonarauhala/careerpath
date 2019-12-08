//
//  CareerEntity+CoreDataProperties.swift
//  Career Path
//
//  Created by mikael on 24/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//
//

import Foundation
import CoreData


extension CareerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CareerEntity> {
        return NSFetchRequest<CareerEntity>(entityName: "CareerEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var salary: Double
    @NSManaged public var degree: Int16
    @NSManaged public var personalityType: Int16
    @NSManaged public var careerDescription: String?
    @NSManaged public var demand: Int16
    @NSManaged public var keyword1: Int16
    @NSManaged public var keyword2: Int16
    @NSManaged public var keyword3: Int16
    @NSManaged public var keyword4: Int16
    @NSManaged public var dominantKeyword: Int16
    

}
