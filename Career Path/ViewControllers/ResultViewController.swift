//
//  ResultViewController.swift
//  Career Path
//
//  Created by iosdev on 25/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
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
        //"personal type" result and description based on "personal type" test
        resultLabel.text = personalityTest1.definePersonalityType(responses: responses).rawValue
        descriptionText.text = personalityTest1.definePersonalityType(responses: responses).description
    }
    

}
