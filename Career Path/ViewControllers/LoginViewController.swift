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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       colorSetup(theme: .t9)
        
        // Disable login button
        loginButton.isEnabled = false
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
        guard let username = usernameField.text else {
            return
        }
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        enableLoginButton()
        guard let password = passwordField.text else {
            return
        }
    }
    
    // Button action
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        userExists()
    }
    
    func userExists() -> Bool {
        NetworkRequest().fetchGetUsers{data in
            print(data)
            
        }
        
        return false
    }
    
    //styling
    fileprivate func colorSetup(theme: Themes) {
        view.backgroundColor = UIColor.viewBackground(theme: colorTheme)
        loginButton.backgroundColor = UIColor.testButtonsBackground(theme: colorTheme)
        loginButton.setTitleColor(UIColor.testButtonsTitle(theme: colorTheme), for: .normal)
    }
}
