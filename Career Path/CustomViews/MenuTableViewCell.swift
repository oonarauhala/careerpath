//
//  MenuTableViewCell.swift
//  Career Path
//
//  Created by iosdev on 01/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    //MARK: Properties
    //image view for icon
    @IBOutlet weak var icon: UIImageView!
    //label for menu item
    @IBOutlet weak var menu_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
