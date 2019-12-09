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
        colorSetup(theme: .t9)
        navigationItem.hidesBackButton = true
        self.title = "Test Results"
        addSlideMenuButton()
        //"personal type" result and description based on "personal type" test
        resultLabel.text = personalityTest1.definePersonalityType(responses: responses).rawValue
        descriptionText.text = personalityTest1.definePersonalityType(responses: responses).description
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults", let destination = segue.destination as? CareerListViewController {
            destination.displayState = .Results
            destination.results = TestResults(user: User("asd", "sfsdfasdasd", 50), personalityType: personalityTest1.definePersonalityType(responses: responses), keywords: [TypeAndFrequency]())
        }
    }
    
    fileprivate func colorSetup(theme: Themes) {
        
        view.backgroundColor = UIColor.viewBackground(theme: colorTheme)
        result_button.backgroundColor = UIColor.testButtonsBackground(theme: colorTheme)
        result_button.setTitleColor(UIColor.testButtonsTitle(theme: colorTheme), for: .normal)
        resultLabel.textColor = UIColor(hex:"#0066CBff")
        descriptionText.textColor = UIColor.testHeaderAndQuestion(theme: colorTheme)
        personality_label.textColor = UIColor.testHeaderAndQuestion(theme: colorTheme)
    }
    

}
