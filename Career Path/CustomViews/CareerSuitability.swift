//
//  CareerSuitability.swift
//  Career Path
//
//  Created by mikael on 08/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

// The suitability bar for a career list cell

class CareerSuitability: UIProgressView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = UIColor.sortingButtons(theme: .t9)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
