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
    
    // Outlets for all fields
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    //actions for all fields
    @IBAction func usernameEditingChanged(_ sender: UITextField) {
        guard let username = usernameField.text else {
            return
        }
        if username.isValid(.username) {
            print("Username is valid")
            
            //set username to core data/database HERE!!
            
            validFields += 1
            
            //if all fields are valid, enable button
            if validFields == 4 {
                //enable button
            }
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
            
            //if all fields are valid, enable button
            if validFields == 4 {
                //enable button
            }
        }
        else {
            //show user email was not valid
            print("Not a valid email")
        }
    }
}
