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
    
    @IBAction func sortByPressed(_ sender: Any) {
        expandedElements.isHidden = !expandedElements.isHidden
    }
    
    private func createShadows(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.5
    }
    
    private func setupButtons() {
        createShadows(button: salaryButton)
        createShadows(button: degreeButton)
        createShadows(button: alphabeticalButton)
    }
    
}
