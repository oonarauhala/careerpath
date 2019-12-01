//
//  ResultsController.swift
//  Career Path
//
//  Created by mikael on 01/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class CareerResultsController: UIViewController {
    
    var testCareers = [Career]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let career1 = Career(careerName: "Actor", description: "test23e23r3wr2 asd asdasdasdasdasdasdasdasdasdasdasdsadasdasdd", medianSalary: 345345, education: Degree.Bachelor, personalityType: PersonalityType.ENFJ, demand: Demand.Low)
        
        let career2 = Career(careerName: "Actuary", description: "test23e23r3wr2asdasd asd asdas dasdas d", medianSalary: 345345, education: Degree.Bachelor, personalityType: PersonalityType.ENFJ, demand: Demand.Low)
        
        let career3 = Career(careerName: "Accountant", description: "test23e23r3wr2 asd asd asdsad asda sdasdasda sdas", medianSalary: 345345, education: Degree.Bachelor, personalityType: PersonalityType.ENFJ, demand: Demand.Low)
        
        testCareers.append(career1)
        testCareers.append(career2)
        testCareers.append(career3)
        
        performSegue(withIdentifier: "ShowResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults", let destination = segue.destination as? CareerListViewController {
            destination.displayState = .Results
            // testCareers should be replaced with the actual
            // careers that are suggested based on test results
            destination.resultCareers = testCareers
        }
    }
}
