//
//  CareerListHeader.swift
//  Career Path
//
//  Created by mikael on 30/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class CareerListHeader: UITableViewHeaderFooterView {
    
    // MARK: Properties

    var expanded: Bool = false
    
    @IBOutlet weak var sortByButton: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerContainer: UIStackView!
    @IBOutlet weak var expandedElements: UIStackView! {
        didSet {
            expandedElements?.isHidden = true
        }
    }
    @IBOutlet weak var salaryButton: UIButton!
    @IBOutlet weak var alphabeticalButton: UIButton!
    @IBOutlet weak var degreeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtons()
    }
    
    func initialSetup(title: String) {
        headerTitle.text = title
    }
    
    @IBAction func sortByPressed(_ sender: UIButton = UIButton()) {
        let originalAlpha: CGFloat = 1
        
        if expandedElements.isHidden {
            sortByButton.setTitle("Hide", for: .normal)
            sender.alpha = originalAlpha * 0.75
            self.frame.size.height = 250
            print(self.frame.size.height)
        } else {
            sortByButton.setTitle("Sort", for: .normal)
            sender.alpha = originalAlpha
            self.frame.size.height = 100
            print(self.frame.size.height)
        }
        expandedElements.isHidden = !expandedElements.isHidden
        UIButton.animate(
            withDuration: 0.15, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.33, y: 0.33)},
                completion: { finish in
                UIButton.animate(withDuration: 0.15, animations: {
                    sender.transform = CGAffineTransform.identity
                })
        })
    }
    
    func setButtonTitles(salaryAscending: Bool, degreeAscending: Bool, nameAscending: Bool) {
        var titleForSalaryButton = "Sort by salary (descending)"
        var titleForDegreeButton = "Sort by education (descending)"
        var titleForAlphabeticalButton = "Sort by name (A - Z)"
        
        if !salaryAscending {
            titleForSalaryButton = "Sort by salary (ascending)"
        }
        if !degreeAscending {
            titleForDegreeButton = "Sort by education (ascending)"
        }
        if !nameAscending {
            titleForAlphabeticalButton = "Sort by name (Z - A)"
        }
        setButtonTitles(titleForSalaryButton, titleForAlphabeticalButton, titleForDegreeButton)
    }
    
    func setButtonTitles(_ salaryTitle: String,_ nameTitle: String,_ degreeTitle: String) {
        salaryButton.setTitle(salaryTitle, for: .normal)
        alphabeticalButton.setTitle(nameTitle, for: .normal)
        degreeButton.setTitle(degreeTitle, for: .normal)
    }
    
    private func createButtonStyles(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowRadius = 1.5
        button.layer.shadowOpacity = 0.8
        button.layer.cornerRadius = 5
        button.backgroundColor = createRBG(r: 100, g: 200, b: 150)
        
    }
    
    private func setupButtons() {
        createButtonStyles(button: salaryButton)
        createButtonStyles(button: degreeButton)
        createButtonStyles(button: alphabeticalButton)
        createButtonStyles(button: sortByButton)
    }
}

extension CareerListHeader {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1
        pulse.fromValue = 0.9
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 0
        pulse.initialVelocity = 1
        pulse.damping = 1
        layer.add(pulse, forKey: nil)
    }
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 0
        layer.add(flash, forKey: nil)
    }
    
}

extension CareerListHeader {
    func createRBG(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        let color = UIColor(displayP3Red: r/255, green: g/255, blue: b/255, alpha: a)
        return color
    }
}
