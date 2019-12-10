//
//  RegistrationViewController.swift
//  Career Path
//
//  Created by iosdev on 27/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

// View controller for registration page
// Includes some validation logic for responsiveness

class RegisterViewController: UIViewController {
    // Outlets for all fields
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    //MARK:Properties
    let colorTheme: Themes = .t9
    
    var isFromResults = false
    var resultsPersonalityType: PersonalityType?
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSetup(theme: .t9)
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
    
    // Changes text colour to red
    func red(field: UITextField) {
        field.textColor = UIColor.red    }
    
    // Changes text colour to black
    func black(field: UITextField) {
        field.textColor = UIColor.black
    }
    
    
    // Actions for all fields
    @IBAction func usernameEditingChanged(_ sender: UITextField) {
        disableButton()
        black(field: usernameField)
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
            red(field: usernameField)
            
            print("Not a valid username")
        }
    }
    
    @IBAction func emailEditingChanged(_ sender: UITextField) {
        black(field: emailField)
        disableButton()
        guard let email = emailField.text else {
            return
        }
        if email.isValid(.email) {
            black(field: emailField)
            print("Email is valid")
            emailValidity = true
            checkFields()
        }
        else {
            red(field: emailField)
            emailValidity = false
            
            print("Not a valid email")
        }
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        black(field: passwordField)
        disableButton()
        guard let password1 = passwordField.text else {
            return
        }
        if password1.isValid(.password) {
            black(field: passwordField)
            print("Password is valid")
        }
        else {
            red(field: passwordField)
            print("Password should be 4-8 characters, numbers or letters")
        }
    }
    
    @IBAction func password2EditingChanged(_ sender: UITextField) {
        black(field: password2Field)
        disableButton()
        guard let password2 = password2Field.text else {
            return
        }
        guard let password1 = passwordField.text else {
            return
        }
        
        if password2.isValid(.password) {
            black(field: password2Field)
            print("Password2 is valid")
            
            if password1 == password2 {
                passwordValidity = true
                checkFields()
            }
            else {
                passwordValidity = false
                red(field: password2Field)
                print("Passwords don't match, sender:a field2")
            }
        }
        else {
            red(field: password2Field)
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
            
            // should not be allowed to come back after this.
            // how to disable viewcontroller / remove from navigation stack..?
            if isFromResults {
                performSegue(withIdentifier: "RegisterResults", sender: self)
            } else {
                performSegue(withIdentifier: "RegisterHome", sender: self)
            }
            
            user = User(username1, email1, password1)
            
            NetworkRequest().fetchPostUser(username: username1, email: email1, password: password1)
        }
        
        // Send/save data here
    }
    @IBAction func goToLogin(_ sender: Any) {
        performSegue(withIdentifier: "RegisterLogin", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisterResults", let destination = segue.destination as? CareerListViewController {
            
            guard let type = UserDefaults.standard.object(forKey: "MyResults") as? Int else { fatalError("Pers. type not Int") }
            guard let personalityType = PersistenceService.getTestResults() else {
                fatalError("No personality type found from results - RegistrationViewController") }
            
            print("Personality type from UserDefaults: ", PersistenceService.convertToPersonalityType(intValue: type))

            guard let u = user else { fatalError("Saving user with register fields failed") }
            
            destination.displayState = .Results
            destination.results = TestResults(user: u, personalityType: personalityType)
        }
        else if segue.identifier == "RegisterHome" {
            PersistenceService.setUserLoggedIn()
        }
        else if segue.identifier == "RegisterLogin", let destination = segue.destination as? LoginViewConroller {
            if isFromResults {
                print("Is from results: ", isFromResults)
                destination.isFromResults = true
            }
        }
    }
    
    
    
    
    fileprivate func colorSetup(theme: Themes) {
        view.backgroundColor = UIColor.viewBackground(theme: colorTheme)
        registerButton.backgroundColor = UIColor.testButtonsBackground(theme: colorTheme)
        registerButton.setTitleColor(UIColor.testButtonsTitle(theme: colorTheme), for: .normal)
    }
    
    
}
