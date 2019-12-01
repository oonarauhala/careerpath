//
//  CareerInfoViewController.swift
//  CareerPath
//
//  Created by mikael on 18/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//
// The controller for a single career scene
// Contains all there is to know about the selected career
// and presents it onto the scene

import UIKit

class CareerInfoViewController: UIViewController {
    
    //MARK: Properties
    
    var career: Career?
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
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
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
    
    func initialSetup() {
        guard let careerUnwrapped = career else {
            fatalError("Career not found from segue")
        }
        salaryLabel.text = "Salary: \(careerUnwrapped.salaryToString)"
        descriptionLabelSetup(c: careerUnwrapped)
        educationLabelSetup(c: careerUnwrapped)
    }
    
    func descriptionLabelSetup(c: Career) {
        descriptionLabel.text = c.description
    }
    
    func educationLabelSetup(c: Career) {
        educationLabel.text = c.educationRequirement.rawValue
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
        guard let careerUnwrapped = career else {
            fatalError("Career not found from segue")
        }
        let careerDsc = careerUnwrapped.educationRequirement.description()
        let alert = UIAlertController(
            title: careerUnwrapped.educationRequirement.rawValue,
            message: careerDsc, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}


