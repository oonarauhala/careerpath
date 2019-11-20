//
//  RoundButton.swift
//  Career_Path
//
//  Created by iosdev on 19/11/2019.
//  Copyright © 2019 iosdev. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        // Common logic goes here
        refreshCorners(value: cornerRadius)
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    @IBInspectable var alphaPercent : CGFloat {
        get {
            return self.alpha * 100
        }
        set(percentage) {
            self.alpha = percentage / 100
        }
    }
    
    
}

