//
//  RegistrationViewController.swift
//  Career Path
//
//  Created by iosdev on 27/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    var validFields = 0
    
    func checkNumberOfFields() {
        if validFields == 4 {
            //enable button
        }
        else {
            print("Only \(validFields) fields are valid")
        }
    }
    
    // Outlets for all fields
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var password2Field: UITextField!
    
    //actions for all fields
    @IBAction func usernameEditingChanged(_ sender: UITextField) {
        guard let username = usernameField.text else {
            return
        }
        if username.isValid(.username) {
            print("Username is valid")
            
            //set username to core data/database HERE!!
            
            validFields += 1
            checkNumberOfFields()
        }
        else {
            
            //show user their username was not valid
            
            print("Not a valid username")
        }
    }
    
    @IBAction func emailEditingChanged(_ sender: UITextField) {
        guard let email = emailField.text else {
            return
        }
        if email.isValid(.email) {
            print("Email is valid")
            
            //set email to core data/database HERE!!
            
            validFields += 1
            checkNumberOfFields()
        }
        else {
            
            //show user email was not valid
            
            print("Not a valid email")
        }
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        guard let password = passwordField.text else {
            return
        }
        if password.isValid(.password) {
            print("Password is valid")
            
            validFields += 1
            checkNumberOfFields()
        }
        else {
            
            //show user password was not valid
            
            print("Password should be 4-8 characters, numbers or letters")
        }
    }
    
    @IBAction func password2EditingChanged(_ sender: UITextField) {
        guard let password2 = password2Field.text else {
            return
        }
        guard let password1 = passwordField.text else {
            return
        }
        
        if password2.isValid(.password) {
            print("Password2 is valid")
            
            if password1 == password2 {
                
            
                //set password to core data/database HERE!!
            
                validFields += 1
                checkNumberOfFields()
            }
            else {
                print("Passwords don't match")
            }
        }
        else {
            
            //show user password was not valid
            
            print("Password should be 4-8 characters, numbers or letters")
        }
    }
}
