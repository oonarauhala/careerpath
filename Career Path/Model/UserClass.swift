//
//  UserClass.swift
//  Career Path
//
//  Created by Jani Hyrkäs on 17/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation

// User model

struct User: Codable {
    
    private  let storedUsername: String
    var username: String {
        get {
            return storedUsername
        }
    }
    
    private  let storedEmail: String
    var email: String {
        get {
            return storedEmail
        }
    }
    
    private  let storedPassword: String
    var password: String {
        get {
            return storedPassword
        }
    }
    var testResults: Array<Int> = []
    
    init(_ username: String,_ email: String,_ password: String) {
        if (username).isEmpty || username == "" {
            self.storedUsername = "Anonymous"
        }
        else {
            self.storedUsername = username
        }
        
        if (email).isEmpty || email == "" {
            self.storedEmail = "Anonymous"
        }
        else {
            self.storedEmail = email
        }
        
        if (password).isEmpty || password == "" {
            self.storedPassword = "Anonymous"
        }
        else {
            self.storedPassword = password
        }
    }
}

