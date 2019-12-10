//
//  HomeViewController.swift
//  Career Path
//
//  Created by iosdev on 20/11/2019.
//  Copyright © 2019 Mikael Kuokkanen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Propertie
    @IBOutlet weak var career_test: UIButton!
    @IBOutlet weak var my_results: UIButton!
    @IBOutlet weak var future_jobs: UIButton!
    
    // this should be replaced with some logic that checks the UserDefaults
    var isLoggedIn = true
    
    //MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "#01326Cff") ?? UIColor.white]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FutureDemand", let destination = segue.destination as? CareerListViewController {
            destination.displayState = .FutureDemand
        }
        if segue.identifier == "IsLogged", let destination = segue.destination as? CareerListViewController {
            destination.displayState = .Results
            destination.results = TestResults(user: User("asd", "sfsdfasdasd", "password"), personalityType: PersonalityType.INTP)
            print("User logged in")
            // set the results object and displaystate of CareerListViewController here
            // and save the results to user history
        }
        if segue.identifier == "NotLogged", let destination = segue.destination as? CareerResultsController {
            // pass down the results to destination, so they can be used after registration
            destination.displayState = .Results
            destination.results = TestResults(user: User("asd", "sfsdfasdasd", "password"), personalityType: PersonalityType.INFP)
            print("User not logged in")
        }
    }
    @IBAction func showMyResults(_ sender: Any) {
        if isLoggedIn {
            performSegue(withIdentifier: "IsLogged", sender: self)
        } else {
            performSegue(withIdentifier: "NotLogged", sender: self)
        }
    }
    
}
