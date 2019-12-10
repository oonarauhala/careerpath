//
//  ResultsController.swift
//  Career Path
//
//  Created by mikael on 01/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

// test controller for displaying results

class CareerResultsController: UIViewController {
    
    var testCareers = [Career]()
    
    // This data needs to be passed down again. Or could it be accesed with CareerResultsController.displayState..?
    var displayState: DisplayState? {
        didSet {
            if displayState != nil {
                print("displaySet passed down. displayState:", displayState!)
            }
        }
    }
    // This data needs to be passed down again. Or could it be accesed with CareerResultsController.results..?
    var results: TestResults? {
        didSet {
            if results != nil {
                print("displaySet passed down. displayState:", results!)
            }
        }
    }
    
    @IBOutlet weak var resultsRegisterButton: UIButton!
    @IBOutlet weak var resultsLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyles()
        //performSegue(withIdentifier: "ShowResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults", let destination = segue.destination as? CareerListViewController {
            destination.displayState = .Results
            destination.results = TestResults(user: User("asd", "sfsdfasdasd", "password"), personalityType: PersonalityType.INFP)

        }
    }
    func setupStyles() {
        resultsLoginButton.backgroundColor = UIColor.sortingButtons(theme: .t9)
        resultsRegisterButton.backgroundColor = UIColor.sortingButtons(theme: .t9)
        resultsLoginButton.setTitleColor(UIColor.white, for: .normal)
        resultsRegisterButton.setTitleColor(UIColor.white, for: .normal)
    }
}
