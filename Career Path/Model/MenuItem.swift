//
//  menuItem.swift
//  Career Path
//
//  Created by iosdev on 01/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit


class Item {
    
    //MARK: Properties
    
    var name_item: String
    var icon: UIImage?
    
    //MARK: Initialization
    
    init(name_item: String, icon: UIImage?) {
        
        // Initialize stored properties.
        self.name_item = name_item
        self.icon = icon
    }
    
    
    
}
