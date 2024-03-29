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
    var responses: [Answer]!
    //MARK: labels
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    //MARK: class Personality test instance
    var personalityTest1 = PersonalityTest()
    //MARK: functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        addSlideMenuButton()
        //"personal type" result and description based on "personal type" test
        resultLabel.text = personalityTest1.definePersonalityType(responses: responses).rawValue
        descriptionText.text = personalityTest1.definePersonalityType(responses: responses).description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults", let destination = segue.destination as? CareerListViewController {
            destination.displayState = .Results
            destination.results = TestResults(user: User("asd", "sfsdfasdasd", 50), personalityType: personalityTest1.definePersonalityType(responses: responses))
        }
    }
    

}
