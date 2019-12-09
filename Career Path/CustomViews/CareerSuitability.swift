//
//  CareerSuitability.swift
//  Career Path
//
//  Created by iosdev on 08/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class CareerSuitability: UIProgressView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
