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
    }
    
    func initialSetup(title: String) {
        headerTitle.text = title
    }
    
    @IBAction func sortByPressed(_ sender: Any) {
        expandedElements.isHidden = !expandedElements.isHidden
        print(expandedElements.isHidden)
    }
    
    
}
