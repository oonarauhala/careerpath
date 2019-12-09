//
//  CareerListHeader.swift
//  Career Path
//
//  Created by mikael on 30/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

// This is the controller for the header view
//  of CareerListViewController's TableView

class CareerListHeader: UITableViewHeaderFooterView {
    
// MARK: Properties

    // Implementing a custom lifecycle method to get
    // the updated frame.size.height after the subviews are laid out
    var initiliazed = false {
        didSet {
            self.frame.size.height = 70 + headerTitle.frame.size.height
        }
    }
    let originalAlpha: CGFloat = 1
    
// MARK: Outlets
    
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
    
// MARK: Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//MARK: Actions

    @IBAction func sortByPressed(_ sender: UIButton = UIButton()) {

        UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
            if self.expandedElements.isHidden {
                self.sortByButton.setTitle("Hide", for: .normal)
                self.sortByButton.alpha = self.originalAlpha * 0.65
                self.setButtonAlphas()
                self.expandedElements.isHidden = !self.expandedElements.isHidden
                self.frame.size.height = 220 + self.headerTitle.frame.size.height
            } else {
                self.sortByButton.setTitle("Sort", for: .normal)
                self.sortByButton.alpha = self.originalAlpha
                self.setButtonAlphas()
                self.expandedElements.isHidden = !self.expandedElements.isHidden
                self.frame.size.height = 70 + self.headerTitle.frame.size.height
            }
        })
        expandedElements.backgroundColor = UIColor.black
      
        UIButton.animate(
            withDuration: 0.15, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.33, y: 0.33)},
                completion: { finish in
                UIButton.animate(withDuration: 0.15, animations: {
                    sender.transform = CGAffineTransform.identity
                })
        })
    }

//MARK: Initializers
    
    // -> Gets called from CareerListViewController
    // when initializing this nib
    func initialSetup(theme: Themes) {
        // Theme defines the correct colors to be used
        setupButtons(theme: theme)
        setupViewStyles(theme: theme)
    }
    
    private func setupViewStyles(theme: Themes) {
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.careerListHeaderBackground(theme: theme)
        headerTitle.textColor = UIColor.careerListHeaderTitle(theme: theme)
    }
    
    private func setButtonColors(button: UIButton, theme: Themes) {
        button.backgroundColor = UIColor.sortingButtons(theme: theme)
        button.setTitleColor(UIColor.sortingButtonsTitle(theme: theme), for: .normal)
    }
    
    // -> Creates the styles for the sorting related buttons
    private func createButtonStyles(button: UIButton, theme: Themes) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowRadius = 1.5
        button.layer.shadowOpacity = 0.8
        
       
        setButtonColors(button: button, theme: theme)
    }
    
    private func setupButtons(theme: Themes) {
        createButtonStyles(button: salaryButton, theme: theme)
        createButtonStyles(button: degreeButton, theme: theme)
        createButtonStyles(button: alphabeticalButton, theme: theme)
        createButtonStyles(button: sortByButton, theme: theme)
    }
    
//MARK: Custom functions -> Animations and styling logic
    
    // Setting alpha of the hidden buttons to 0 when
    // collapsing to make it look smoother with the animation
    fileprivate func setButtonAlphas() {
        if self.expandedElements.isHidden {
            alphabeticalButton.alpha = 1
            salaryButton.alpha = 1
            degreeButton.alpha = 1
        } else {
            alphabeticalButton.alpha = 0
            salaryButton.alpha = 0
            degreeButton.alpha = 0
        }
    }
    
    func setButtonTitles(salaryAscending: Bool, degreeAscending: Bool, nameAscending: Bool) {
        var titleForSalaryButton = "Sort by salary ↑"
        var titleForDegreeButton = "Sort by education ↑"
        var titleForAlphabeticalButton = "Sort by name ↑"
        
        if salaryAscending {
            titleForSalaryButton = "Sort by salary ↓"
        }
        if degreeAscending {
            titleForDegreeButton = "Sort by education ↓"
        }
        if nameAscending {
            titleForAlphabeticalButton = "Sort by name ↓"
        }
        setButtonTitles(titleForSalaryButton, titleForAlphabeticalButton, titleForDegreeButton)
    }
    
    func setButtonTitles(_ salaryTitle: String,_ nameTitle: String,_ degreeTitle: String) {
        salaryButton.setTitle(salaryTitle, for: .normal)
        alphabeticalButton.setTitle(nameTitle, for: .normal)
        degreeButton.setTitle(degreeTitle, for: .normal)
    }
}
