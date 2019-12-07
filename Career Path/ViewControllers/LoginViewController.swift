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
    
    var username: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable login button        loginButton.isEnabled = false
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
}
