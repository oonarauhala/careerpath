//
//  LoginViewController.swift
//  Career Path
//
//  Created by iosdev on 27/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class LoginViewConroller: UIViewController {
    
    // Outlets for fields and button
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    

    //MARK:Properties
    let colorTheme: Themes = .t9

    var username: String = ""
    var password: String = ""
    var isFromResults = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
       colorSetup(theme: .t9)
        
        // Disable login button        loginButton.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginResults", let destination = segue.destination as? CareerListViewController {
        
            guard let personalityType = PersistenceService.getTestResults() else {
                fatalError("No personality type found from results - LoginViewController") }
            
            let user = User("asdasd", "asdasd@asd.asd", "asdasd")
            
            destination.displayState = .Results
            destination.results = TestResults(user: user, personalityType: personalityType)
        }
        else if segue.identifier == "RegisterHome" {
            PersistenceService.setUserLoggedIn()
        }
        else if segue.identifier == "LoginRegister", let destination = segue.destination as? RegisterViewController {
            if isFromResults {
                print("is from results: ", isFromResults)
                destination.isFromResults = true
            }
        }
    }
    
    // Enables button
    func enableLoginButton() {
        loginButton.isEnabled = true
    }
    
    // Disables button
    func disableLoginButton() {
        loginButton.isEnabled = false
    }
    
    
    // Field actions
    
    @IBAction func usernameEditingChanged(_ sender: UITextField) {
        enableLoginButton()
        if let value = usernameField.text {
            self.username = value
            print(self.username)
        }

        guard let username1 = usernameField.text else {
            return
        }
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        enableLoginButton()
        if let value = passwordField.text {
            self.password = value
            print(self.password)
        }
        
        guard let password1 = passwordField.text else {
            return
        }
    }
    
    // Button action
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if userExists() == true {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            //prints 0 for false and 1 for true
            print("is user logged in: " + (UserDefaults.standard.string(forKey: "userLoggedIn") ?? ""))
            
            if isFromResults {
                performSegue(withIdentifier: "LoginResults", sender: self)
            } else {
                performSegue(withIdentifier: "LoginHome", sender: self)
            }
        }
    }
    
    func userExists() -> Bool {
        var isUser = false
        let group = DispatchGroup()
        //group is used to control flow so that final return waits for fetchGetUsers loop to complete
        group.enter()
        NetworkRequest().fetchGetUsers{data in
            //Iterate through json user objects
            for object in data {
                //Check if valid and remove optional
                if let username = object["storedUsername"] {
                    print("fetched username: " + String(describing: username))
                    print("entered username: " + self.username)
                    //Check if entered username matches a username in json.db
                    if String(describing: username) == self.username{
                        if let password = object["storedPassword"] {
                            //Check if entered password matches users password
                            print("fetched password: " + String(describing: password))
                            print("entered password: " + self.password)

                            if String(describing: password) == self.password
                            {
                                //If username and password match, return true
                                isUser = true
                                UserDefaults.standard.set(self.username, forKey: "Username")
                                    print("saved username: " + (UserDefaults.standard.string(forKey: "Username") ?? ""))
                            }
                        }
                    }
                }
            }
            group.leave()
        }
        group.wait()
        print(isUser)
        
        return isUser
    }
    
    //styling
    fileprivate func colorSetup(theme: Themes) {
        view.backgroundColor = UIColor.viewBackground(theme: colorTheme)
        loginButton.backgroundColor = UIColor.testButtonsBackground(theme: colorTheme)
        loginButton.setTitleColor(UIColor.testButtonsTitle(theme: colorTheme), for: .normal)
    }
    
    @IBAction func goToRegister(_ sender: Any) {
        performSegue(withIdentifier: "LoginRegister", sender: self)
    }
}
