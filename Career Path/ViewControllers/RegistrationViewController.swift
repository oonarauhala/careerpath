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
    var validFields = 0
    
    // Checks number of valid fields to enable register button
    func checkFields() {
        if validFields == 4 {
            enableRegisterButton()
        }
        else {
            print("Only \(validFields) fields are valid")
        }
    }
    
    // Enables button
    func enableRegisterButton() {
        registerButton.isEnabled = true
    }
    
    
    //actions for all fields
    @IBAction func usernameEditingChanged(_ sender: UITextField) {
        guard let username = usernameField.text else {
            return
        }
        if username.isValid(.username) {
            print("Username is valid")
            
            validFields += 1
            checkFields()
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
            
            validFields += 1
            checkFields()
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
            checkFields()
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
            
                validFields += 1
                checkFields()
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
    
    // Action for register button
    @IBAction func registerButtonTouchUpInside(_ sender: UIButton) {
        
        if registerButton.isEnabled == true {
            print("Button enabled")
        }
        else {
            print("Button disabled")
        }
        
        // Send/save data here
    }
}
