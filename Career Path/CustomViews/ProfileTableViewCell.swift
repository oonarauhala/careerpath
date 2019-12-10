//
//  ProfileTableViewCell.swift
//  Career Path
//
//  Created by iosdev on 02/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    //MARK: Properties
    //image view for "profession image"
    @IBOutlet weak var img: UIImageView!
    //label for career name
    @IBOutlet weak var careerNameLabel: UILabel!
    //label for salary
    @IBOutlet weak var salaryLabel: UILabel!
    //label for degree
    @IBOutlet weak var degreeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setStyles(theme: Themes, cell: UITableViewCell) {
        // Setting the colors based on a theme
        careerNameLabel.textColor = UIColor.careerCellNameText(theme: theme)
        degreeLabel.textColor = UIColor.careerCellDegreeText(theme: theme)
        salaryLabel.textColor = UIColor.careerCellSalaryText(theme: theme)
        self.backgroundColor = UIColor.careerCellBackground(theme: theme)
       
    }

}
