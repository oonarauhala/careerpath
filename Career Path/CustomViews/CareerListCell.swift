//
//  CareerListCell.swift
//  Career Path
//
//  Created by mikael on 22/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class CareerListCell: UITableViewCell {
    
    // new
    let suitabilityBar = CareerSuitability(frame: .zero)
    
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var img: UIImageView!
    // new
    @IBOutlet weak var infoStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // Populates the cells with appropriate data
    func populateCell(career: Career, isResult: Bool = false, progress: Float = 0.5) { // new: isResult, progress
        img.image = UIImage(named: career.careerName)
        name.text = career.careerName
        degree.text = career.educationRequirement.rawValue
        salary.text = "Salary: \(career.separateThousands(value: Int(career.medianSalary)))"
        if isResult {
            addSuitabilityBar(progress: progress)
        }
    }
    
    func setStyles(theme: Themes, cell: UITableViewCell) {
        // Setting the colors based on a theme
        name.textColor = UIColor.careerCellNameText(theme: theme)
        degree.textColor = UIColor.careerCellDegreeText(theme: theme)
        salary.textColor = UIColor.careerCellSalaryText(theme: theme)
        self.backgroundColor = UIColor.careerCellBackground(theme: theme)
//        cell.layer.cornerRadius = 50
//        cell.layer.masksToBounds = true
        
    }
    
    // new
    func addSuitabilityBar(progress: Float) {
        // Adds a progress bar under the name label
        infoStackView.insertArrangedSubview(suitabilityBar, at: 1)
        NSLayoutConstraint.activate([
            suitabilityBar.heightAnchor.constraint(equalToConstant: 4),
            suitabilityBar.widthAnchor.constraint(equalToConstant: infoStackView.frame.width)
            ])
        suitabilityBar.progress = progress
    }
    
}
