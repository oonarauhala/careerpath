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
    //label for name of profession
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
