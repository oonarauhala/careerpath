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
    
    var resultsPersonalityType: PersonalityType?
    
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
            guard let personalityType = PersistenceService.getTestResults() else { fatalError("Error defining personality type - HomeViewController") }
            destination.displayState = .Results
            destination.results = TestResults(user: User("asd", "sfsdfasdasd", "password"), personalityType: personalityType)
        }
        if segue.identifier == "NotLogged" {
            print("User not logged in")
        }
    }
    
    @IBAction func showMyResults(_ sender: Any) {
        if PersistenceService.checkUserLoggedIn() {
            if PersistenceService.checkIfResultsExist() {
                performSegue(withIdentifier: "IsLogged", sender: self)
            } else {
                performSegue(withIdentifier: "NoResults", sender: self)
            }
        } else {
            performSegue(withIdentifier: "NotLogged", sender: self)
        }
    }
    
}
