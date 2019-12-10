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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //performSegue(withIdentifier: "ShowResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults", let destination = segue.destination as? CareerListViewController {
            destination.displayState = .Results
            
            let typeAndF1 = TypeAndFrequency(type: PersonalType.I, frequency: 2)
            let typeAndF2 = TypeAndFrequency(type: PersonalType.N, frequency: 6)
            let typeAndF3 = TypeAndFrequency(type: PersonalType.F, frequency: 8)
            let typeAndF4 = TypeAndFrequency(type: PersonalType.P, frequency: 5)
            
            let testKeywords = [typeAndF1, typeAndF2, typeAndF3, typeAndF4]
            
            destination.results = TestResults(user: User("asd", "sfsdfasdasd", 50), personalityType: PersonalityType.INFP, keywords: testKeywords)
        }
    }
}
