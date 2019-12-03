//
//  RoundImage.swift
//  Career Path
//
//  Created by iosdev on 02/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

@IBDesignable class RoundImage: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
@IBInspectable var maskToBounds: Bool = true {
        didSet{
            layer.masksToBounds = maskToBounds
        }
    }
    
@IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
@IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
