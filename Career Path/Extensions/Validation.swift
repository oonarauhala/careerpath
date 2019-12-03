//
//  Validation.swift
//  Career Path
//
//  Created by Oona on 27/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation

// This file provides validation for user input in registration and login
// In the future, checking for username/email that's already linked to an account happens here

extension String {
    
    // types of strings to be validated
    enum ValidityType {
        case username, email, password
    }
    
    func isValid(_ validityType: ValidityType) -> Bool {
        // %@ means object
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        // username: 4-8 characters, numbers or letters
        case .username:
            regex = "^[a-zA-Z0-9]{4,8}$"
        // email has two backslashes before dot because of swift, \. would be normally used
        case .email:
            regex = "^[a-zA-Z0-9-_]+@[a-zA-Z_]+\\.[a-zA-Z]{2,3}$"
            // 4-8 characters, numbers or letters
        case .password:
            regex = "^[a-zA-Z0-9]{4,8}$"
        }
        
        //evaluate compares string to regex and returns a boolean
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
