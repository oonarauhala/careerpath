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
            enableRegisterButton()
        }
        else {
            disableButton()
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
        field.textColor = UIColor.red
        
    }
    
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
            
            DispatchQueue.global().async {
                let group = DispatchGroup()
                //group is used to control flow so that final return waits for fetchGetUsers loop to complete
                group.enter()
                NetworkRequest().fetchGetUsers{data in
                    //Iterate through json user objects
                    for object in data {
                        //Check if valid and remove optional
                        if let testUsername = object["storedUsername"] {
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
                    self.usernameValidity = false
                }
                else {
                    print("Username is valid")
                    self.usernameValidity = true
                    self.checkFields()
                }
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
            emailValidity = true
            checkFields()
        }
        else {
            red(field: emailField)
            emailValidity = false
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
        }
        else {
            red(field: passwordField)
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
            
            if password1 == password2 {
                passwordValidity = true
                checkFields()
            }
            else {
                passwordValidity = false
                red(field: password2Field)
            }
        }
        else {
            red(field: password2Field)
        }
    }
    
    // Action for register button
    @IBAction func registerButtonTouchUpInside(_ sender: UIButton) {
        
        if registerButton.isEnabled == true {
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
            
            if isFromResults {
                // if isFromResults -> personality type should be defined too -> if it isn't -> crash app.
                guard let res = resultsPersonalityType else { fatalError("Is from results but personality type not found. (RegistrationViewController)") }
                
                NetworkRequest().fetchPostUser(username: username1, email: email1, password: password1, personalityTypeInt: res.convertToInt())
                PersistenceService.saveUserToDefaults(username: username1, email: email1, results: res.convertToInt(), password: password1)
            } else {
                NetworkRequest().fetchPostUser(username: username1, email: email1, password: password1)
                PersistenceService.saveUserToDefaults(username: username1, email: email1, results: nil, password: password1)
            }
        }
        
        // Send/save data here
    }
    @IBAction func goToLogin(_ sender: Any) {
        performSegue(withIdentifier: "RegisterLogin", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisterResults", let destination = segue.destination as? CareerListViewController {
            
            guard let type = resultsPersonalityType else { fatalError("Pers. type not given from CareerListVC") }
            guard let username1 = usernameField.text else { fatalError("error with username") }
            guard let password1 = passwordField.text else { fatalError("error with password") }
            guard let email1 = emailField.text else { fatalError("error with email") }
            
            print("Personality type from UserDefaults: ", type)

            var user = User(username1, email1, password1)
            user.testResults.append(type.convertToInt())
            
            PersistenceService.setUserLoggedIn()
            destination.displayState = .Results
            destination.results = TestResults(user: user, personalityType: type)
        }
            
        else if segue.identifier == "RegisterHome" {
            PersistenceService.setUserLoggedIn()
        }
            
        else if segue.identifier == "RegisterLogin", let destination = segue.destination as? LoginViewConroller {
            print(isFromResults)
            if isFromResults {
                print("Is from results: ", isFromResults)
                destination.isFromResults = true
                guard let personalityType = resultsPersonalityType else { fatalError("trying to leave without passing down personality type") }
                destination.resultsPersonalityType = personalityType
            }
        }
    }
    
    
    
    
    fileprivate func colorSetup(theme: Themes) {
        view.backgroundColor = UIColor.viewBackground(theme: colorTheme)
        registerButton.backgroundColor = UIColor.testButtonsBackground(theme: colorTheme)
        registerButton.setTitleColor(UIColor.testButtonsTitle(theme: colorTheme), for: .normal)
    }
    
    
}
