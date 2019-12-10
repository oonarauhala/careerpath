//
//  ResultViewController.swift
//  Career Path
//
//  Created by iosdev on 25/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    
    //MARK: variables
    let colorTheme: Themes = .t9
    var responses: [Answer]!
    //MARK: labels
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var result_button: UIButton!
    @IBOutlet weak var personality_label: UILabel!
    
    //MARK: class Personality test instance
    var personalityTest1 = PersonalityTest()
    //MARK: functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.title = "Test Results"
        addSlideMenuButton()
        //"personal type" result and description based on "personal type" test
        let personality = personalityTest1.definePersonalityType(responses: responses).rawValue
        resultLabel.text = personalityTest1.definePersonalityType(responses: responses).rawValue
        descriptionText.text = personalityTest1.definePersonalityType(responses: responses).description

        UserDefaults.standard.set(personality, forKey: "lastResult")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults", let destination = segue.destination as? CareerListViewController {
            destination.displayState = .Results
            destination.results = TestResults(user: User("asd", "sfsdfasdasd", "password"), personalityType: personalityTest1.definePersonalityType(responses: responses))
            
            saveResultsIfLogged()
        }
        else if segue.identifier == "ResultsRegister", let destination = segue.destination as? RegisterViewController {
            destination.isFromResults = true
            destination.resultsPersonalityType = personalityTest1.definePersonalityType(responses: responses)
        }
    }
    
    private func saveResultsIfLogged() {
        if PersistenceService.checkUserLoggedIn() {
            PersistenceService.saveTestResults(type: personalityTest1.definePersonalityType(responses: responses))
        }
    }
}
