//
//  CareerInfoViewController.swift
//  CareerPath
//
//  Created by iosdev on 18/11/2019.
//  Copyright © 2019 Mikael Kuokkanen. All rights reserved.
//

import UIKit

let testDescription = """
An astronomer is a scientist in the field of astronomy who focuses their studies on a specific question or field outside the scope of Earth. They observe astronomical objects such as stars, planets, moons, comets, and galaxies – in either observational (by analyzing the data) or theoretical astronomy. Examples of topics or fields astronomers study include planetary science, solar astronomy, the origin or evolution of stars, or the formation of galaxies. Related but distinct subjects like physical cosmology, which studies the Universe as a whole.

Astronomers usually fall under either of two main types: observational and theoretical. Observational astronomers make direct observations of celestial objects and analyze the data. In contrast, theoretical astronomers create and investigate models of things that cannot be observed. Because it takes millions to billions of years for a system of stars or a galaxy to complete a life cycle, astronomers must observe snapshots of different systems at unique points in their evolution to determine how they form, evolve, and die. They use these data to create models or simulations to theorize how different celestial objects work.
"""

let testCareer = Career(careerName: "Astronomer", description: testDescription, medianSalary: 105680, education: Degree.Doctorate, personalityType: PersonalityType.INTJ)


class CareerInfoViewController: UIViewController {
    
    //MARK: Properties
    
    // Views
    @IBOutlet weak var scrollView: UIScrollView!
    // Labels
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var educationTitleLabel: UILabel!
    // Custom
    private var showMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        salaryLabel.text = "Salary: \(testCareer.salaryToString)"
        descriptionLabelSetup()
        educationLabelSetup()
        toggleShowMore()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
            
        }
    }
    
    //MARK: Initializers
    
    func descriptionLabelSetup() {
        descriptionLabel.text = testCareer.description
    }
    
    func educationLabelSetup() {
        educationLabel.text = testCareer.educationRequirement.rawValue
        educationLabel.textColor = .blue
        // create a gesture recognizer
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.showEducationInfo))
        // add it to the education label
        educationLabel.addGestureRecognizer(labelTapGesture)
    }
    
    //MARK: Actions
    
    @IBAction func showMorePressed(_ sender: UIButton) {
        showMore = !showMore
        toggleShowMore()
    }
    
    //MARK: Private Functions
    
    // Has the description label display only a certain number of lines when collapsed
    private func toggleShowMore() {
        if (!showMore) {
            descriptionLabel.numberOfLines = 3
            showMoreButton.setTitle("show more...", for: .normal)
            scrollView.setContentOffset(.zero, animated: false)
        } else {
            descriptionLabel.numberOfLines = 0
            showMoreButton.setTitle("show less...", for: .normal)
        }
    }
    
    @objc private func showEducationInfo() {
        let alert = UIAlertController(title: testCareer.educationRequirement.rawValue, message: testCareer.educationRequirement.description(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}


