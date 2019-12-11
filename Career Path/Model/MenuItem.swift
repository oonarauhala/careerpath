//
//  menuItem.swift
//  Career Path
//
//  Created by iosdev on 01/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation
import UIKit

// Model for menu item

class Item {
    
    //MARK: Properties
    
    var name_item: String
    var icon: UIImage?
    
    //MARK: Initialization
    //failable_initializer
    
    init?(name_item: String, icon: UIImage?) {
        
        // The name_item must not be empty
        guard !name_item.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name_item = name_item
        self.icon = icon
    }
    
    
    
}
