//
//  RegistrationViewController.swift
//  Career Path
//
//  Created by iosdev on 27/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

// View controller for registration page

class RegisterViewController: UIViewController {
    // Outlets for all fields
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable register button
        registerButton.isEnabled = false
    }
    
    // Keeps track of valid fiels to enable register button
    var usernameValidity = false
    var emailValidity = false
    var passwordValidity = false
    
    // Checks number of valid fields to enable register button
    func checkFields() {
        if (usernameValidity == true && emailValidity == true && passwordValidity == true) {
            print("All fields are valid")
            enableRegisterButton()
        }
        else {
            disableButton()
            print("All fields are not valid")
        }
    }
    
    // Enables button
    func enableRegisterButton() {
        registerButton.isEnabled = true
    }
    
    // Disables button
    func disableButton() {
        registerButton.isEnabled = false
    }
    
    
    // Actions for all fields
     @IBAction func usernameEditingChanged(_ sender: UITextField) {
        disableButton()
        guard let username = usernameField.text else {
            return
        }
        if username.isValid(.username) {
            var usernameTaken = false
            let group = DispatchGroup()
            //group is used to control flow so that final return waits for fetchGetUsers loop to complete
            group.enter()
            NetworkRequest().fetchGetUsers{data in
                //Iterate through json user objects
                for object in data {
                    //Check if valid and remove optional
                    if let testUsername = object["storedUsername"] {
                        print("fetched username: " + String(describing: testUsername))
                        print("entered username: " + username)
                        //Check if entered username matches a username in json.db
                        if String(describing: testUsername) == username {
                            usernameTaken = true
                            print("Username taken, try another one")
                            break
                        }
                    }
                }
                group.leave()
            }
            
            group.wait()
            if usernameTaken == true {
                usernameValidity = false
            }
            else {
                print("Username is valid")
                usernameValidity = true
                checkFields()
            }
        }
        else {
            usernameValidity = false
            //show user their username was not valid
            
            print("Not a valid username")
        }
    }
    
    @IBAction func emailEditingChanged(_ sender: UITextField) {
        disableButton()
        guard let email = emailField.text else {
            return
        }
        if email.isValid(.email) {
            print("Email is valid")
            emailValidity = true
            checkFields()
        }
        else {
            emailValidity = false
            //show user email was not valid
            
            print("Not a valid email")
        }
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        disableButton()
        guard let password1 = passwordField.text else {
            return
        }
        guard let password2 = password2Field.text else {
            return
        }
        if password1.isValid(.password) {
            print("Password is valid")
            
            if password1 == password2 {
                passwordValidity = true
                checkFields()
            }
            else {
                passwordValidity = false
                print("Passwords don't match, sender: field1")
            }
        }
        else {
            
            //show user password was not valid
            
            print("Password should be 4-8 characters, numbers or letters")
        }
    }
    
    @IBAction func password2EditingChanged(_ sender: UITextField) {
        disableButton()
        guard let password2 = password2Field.text else {
            return
        }
        guard let password1 = passwordField.text else {
            return
        }
        
        if password2.isValid(.password) {
            print("Password2 is valid")
            
            if password1 == password2 {
            passwordValidity = true
                checkFields()
            }
            else {
                passwordValidity = false
                print("Passwords don't match, sender:a field2")
            }
        }
        else {
            
            //show user password was not valid
            
            print("Password should be 4-8 characters, numbers or letters")
        }
    }
    
    // Action for register button
    @IBAction func registerButtonTouchUpInside(_ sender: UIButton) {
        
        if registerButton.isEnabled == true {
            print("Button enabled")
            guard let username1 = usernameField.text else {
                return
            }
            guard let password1 = passwordField.text else {
                return
            }
            guard let email1 = emailField.text else {
                return
            }
            
            NetworkRequest().fetchPostUser(username: username1, email: email1, password: password1)
        }
        
        // Send/save data here
    }
}
