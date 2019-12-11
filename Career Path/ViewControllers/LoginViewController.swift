//
//  LoginViewController.swift
//  Career Path
//
//  Created by iosdev on 27/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

// Controller for login view, includes checking for existing usernames

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
    var resultsPersonalityType: PersonalityType?

    
    override func viewDidLoad() {
        super.viewDidLoad()
       colorSetup(theme: .t9)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginResults", let destination = segue.destination as? CareerListViewController {
        
            guard let personalityType = resultsPersonalityType else {
                fatalError("No personality type found from results - LoginViewController") }
            
            let user = User("asdasd", "asdasd@asd.asd", "asdasd")
            
            PersistenceService.setUserLoggedIn()
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
                guard let personalityType = resultsPersonalityType else { fatalError("trying to leave login without passing down a proper personality type") }
                destination.resultsPersonalityType = personalityType
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

    
    // Button action
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        DispatchQueue.global().async {
            if self.userExists() == true {
                DispatchQueue.main.async {
                    PersistenceService.setUserLoggedIn()

                    print("is user logged in: ", (PersistenceService.checkUserLoggedIn()))
                    
                    if self.isFromResults {
                        self.performSegue(withIdentifier: "LoginResults", sender: self)
                    } else {
                        self.performSegue(withIdentifier: "LoginHome", sender: self)
                    }
                }
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
                if let username = object["storedUsername"] as? String {
                    print("fetched username: " + String(describing: username))
                    print("entered username: " + self.username)
                    //Check if entered username matches a username in json.db
                    if String(describing: username) == self.username{
                        if let password = object["storedPassword"] as? String {
                            //Check if entered password matches users password
                            print("fetched password: " + String(describing: password))
                            print("entered password: " + self.password)

                            if String(describing: password) == self.password
                            {
                                if let email = object["storedEmail"] as? String, let testResults = object["testResults"] as? [Int] {
                                    if testResults.isEmpty {
                                        PersistenceService.saveUserToDefaults(username: username, email: email, results: nil, password: password)
                                    } else {
                                        PersistenceService.saveUserToDefaults(username: username, email: email, results: testResults.last, password: password)
                                    }
                                    print("saved username: \(username), saved email: \(email), saved results: \(testResults) ")
                                }
                                //If username and password match, return true
                                isUser = true
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
    
    // Segue to register view
    @IBAction func goToRegister(_ sender: Any) {
        performSegue(withIdentifier: "LoginRegister", sender: self)
    }
}
