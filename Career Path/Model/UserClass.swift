//
//  UserClass.swift
//  Career Path
//
//  Created by Jani Hyrkäs on 17/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation

class User {
    
    private  let storedFirstName: String
    var firstName: String {
        get {
            return storedFirstName
        }
    }
    
    private  let storedLastName: String
    var lastName: String {
        get {
            return storedLastName
        }
    }
    
    
    private var storedAge: Int
    var age: Int {
        get {
            return storedAge
        }
        
        set {
            if newValue < storedAge {
                
            }
            else if newValue < 16 {
                
            }
            else {
                storedAge = newValue
            }
        }
    }
    
    init(_ firstName: String,_ lastName: String,_ age: Int) {
        if (firstName).isEmpty || firstName == "" {
            self.storedFirstName = "Anonymous"
        }
        else {
            self.storedFirstName = firstName
        }
        if (lastName).isEmpty || lastName == "" {
            self.storedLastName = "Anonymous"
        }
        else {
            self.storedLastName = lastName
        }
        
        if age < 16 || age > 150 {
            self.storedAge = 0
        }
        else {
            self.storedAge = age
        }
        
    }
    
}

