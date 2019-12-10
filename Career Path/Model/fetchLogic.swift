//
//  fetchLogic.swift
//  Career Path
//
//  Created by iosdev on 10/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation

class fetchLogic {
    
    func getSavedPersonalities() -> [String] {
            guard let username = UserDefaults.standard.string(forKey: "Username") else { return []}
        var array: [String] = []
            let group = DispatchGroup()
            //group is used to control flow so that final return waits for fetchGetUsers loop to complete
            group.enter()
            NetworkRequest().fetchGetUsers{data in
                //Iterate through json user objects
                for object in data {
                    if let fetchedUsername = object["storedUsername"] {
                        print("fetched username: " + String(describing: username))
                        print("stored username: " + username)
                        if String(describing: fetchedUsername) == username {
                            if let fetchedArray = object["testResults"] as? [String]{
                                       array = fetchedArray
                            }
                        }
                    }
                }
                group.leave()
            }
            group.wait()
         return array
        
    }
    
    func savePersonality() {
        guard let username = UserDefaults.standard.string(forKey: "Username") else { return}
        
        let group = DispatchGroup()
        //group is used to control flow so that final return waits for fetchGetUsers loop to complete
        group.enter()
        NetworkRequest().fetchGetUsers{data in
            //Iterate through json user objects
            for object in data {
                if let fetchedUsername = object["storedUsername"] {
                    print("fetched username: " + String(describing: username))
                    print("stored username: " + username)
                    if String(describing: fetchedUsername) == username {
                        if let password = object["storedPassword"] {
                            
                            print("fetched password: " + String(describing: password))
                            if let email = object["storedEmail"] {
                                if var array = object["testResults"] as? [String]{
                                    print(array)
                                    guard let lastResult = UserDefaults.standard.string(forKey: "lastResult") else {
                                        print("no saved recent results")
                                        return
                                    }
                                    array.append(lastResult)
                                    
                                    var user = User(username, String(describing: email), String(describing: password))
                                    user.testResults = array
                                    guard let ID = object["id"] else {
                                        return
                                    }
                                    NetworkRequest().fetchUpdateUser(user: user, userID: String(describing: ID))
                                }
                            }
                        }
                    }
                }
            }
            group.leave()
        }
        group.wait()
        
    }
}
