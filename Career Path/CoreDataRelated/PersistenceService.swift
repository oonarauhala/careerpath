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
                    // Splitting the personality type into its components (keywords).
                    // These components will be used as predicates for offering
                    // the best possible career recommendations.
                    var keywords: [Int16] = []
                    for component in careerEntity.convertToCareer().personalityType.getComponents() {
                        keywords.append(Int16(component.convertToInt()))
                    }
                    careerEntity.keyword1 = keywords[0]
                    careerEntity.keyword2 = keywords[1]
                    careerEntity.keyword3 = keywords[2]
                    careerEntity.keyword4 = keywords[3]
                    // The 0th component is always the first letter of the personality type, hence "dominant"
                    careerEntity.dominantKeyword = keywords[0]
                    
                    contextNeedsSaving = true
                }
            } catch {
                print(error)
            }
        }
        // The View Controller controlling the list of careers
        // will update its TableView upon context change, so notifying it here.
        if (contextNeedsSaving) {
            saveContext()
        }
    }
    static func convertToPersonalityType(intValue: Int) -> PersonalityType {
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
            fatalError("PersonalityType value needs to be in range 0..16")
        }
    }
    
    static func saveTestResults(type: PersonalityType) {
        
        UserDefaults.standard.set(type.convertToInt(), forKey: "MyResults")
    }
    
    static func setUserLoggedIn() {
        UserDefaults.standard.set(true, forKey: "userLoggedIn")
    }
    
    static func setUserLoggedOut() {
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    static func checkUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "userLoggedIn")
    }
    
    static func checkIfResultsExist() -> Bool {
        return UserDefaults.standard.bool(forKey: "MyResults")
    }
    
    static func getUserFromDefaults() -> User? {
        if checkUserLoggedIn() {
            guard let name = UserDefaults.standard.string(forKey: "Username") else { fatalError("name not stored as string") }
            guard let email = UserDefaults.standard.string(forKey: "Email") else { fatalError("email not stored as string") }
            guard let results = UserDefaults.standard.object(forKey: "MyResults") as? [Int] else { fatalError("results not stored as [Int]") }
            var user = User(name, email, "password")
            user.testResults = results
            return user
        } else {
            return nil
        }
    }
    
    static func saveUserToDefaults(username: String, email: String, results: Int?) {
        UserDefaults.standard.set(username, forKey: "Username")
        UserDefaults.standard.set(email, forKey: "Email")
        UserDefaults.standard.set(results, forKey: "MyResults")
        print("saved to UserDefaults -> name: \(username), email: \(email), results: \(String(describing: results))")
    }
    
    static func saveUserToBackEnd(user: User) {
        var userExists = false
        var userID: Int?
        DispatchQueue.global().async {
            let group = DispatchGroup()
            let request = NetworkRequest()
            print("user results", user.testResults)
            //group is used to control flow so that final return waits for fetchGetUsers loop to complete
            group.enter()
            request.fetchGetUsers{data in
                
                //Iterate through json user objects
                for object in data {
                    //Check if valid and remove optional
                    if let testUsername = object["storedUsername"] as? String {
                        print("fetched username: " + String(describing: testUsername))
                        print("entered username: " + user.username)
                        //Check if entered username matches a username in json.db
                        if testUsername == user.username {
                            if let id = object["id"] as? Int {
                                userID = id
                            }
                            userExists = true
                            break
                        }
                    }
                }
                group.leave()
            }
            
            group.wait()
            if userExists == true {
                // update user results
                print("User exists. Updating results")
                guard let id = userID else { fatalError("error parsing user ID") }
                request.fetchUpdateUser(user: user, userID: String(id))
            }
            else {
                // save new user
                print("User doesn't exist. Saving a new user")
                request.fetchPostUser(username: user.username, email: user.email, password: user.password)
         
            }
        }
    }

    static func getTestResults() -> PersonalityType? {
        if let int = UserDefaults.standard.object(forKey: "MyResults") as? Int {
            return convertToPersonalityType(intValue: int)
        } else {
            return nil
        }
    }
    
    static func clearUserDefaults() {
        print("cleared user defaults")
        setUserLoggedOut()
        UserDefaults.standard.set(nil, forKey: "MyResults")
        UserDefaults.standard.set(nil, forKey: "Username")
        UserDefaults.standard.set(nil, forKey: "Email")
        
    }

}
