//
//  PersistenceService.swift
//  Career Path
//
//  Created by mikael on 24/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation
import CoreData

// The same block of code that core data automatically creates
// inside AppDelegate - turned into a singleton for convenience reasons

class PersistenceService {
    // MARK: - Core Data stack
    
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Career_Path")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: Additions to core data stack
    
    // Compares the CareerEntity context to the result array fetched from the back end
    // Creates a new CareerEntity if one doesn't exist already
    // Saves the context if changes were made
    static func compareCareerContext(responseArray: [CareerResponse]){
        var contextNeedsSaving = false
        
        for response in responseArray {
            let request: NSFetchRequest<CareerEntity> = CareerEntity.fetchRequest()
            request.predicate = NSPredicate(format: "name = %@", response.name)
            do {
                let matchingNames = try context.fetch(request)
                if matchingNames.count == 0 {
                    let careerEntity = CareerEntity(context: context)
                    careerEntity.careerDescription = response.description
                    careerEntity.degree = Int16(response.degree)
                    careerEntity.name = response.name
                    careerEntity.personalityType = Int16(response.personality)
                    careerEntity.salary = Double(response.salary)
                    careerEntity.demand = Int16(response.futureDemand)
                    contextNeedsSaving = true
                }
                else {
                    print("found existing career")
                }
            } catch {
                print(error)
            }
        }
        // The View Controller controlling the list of Careers
        // will update its TableView on context change
        if (contextNeedsSaving) {
            saveContext()
        }
    }

}
