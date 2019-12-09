//
//  AlertService.swift
//  Career Path
//
//  Created by Oona on 24/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

// This file includes the alert function

import UIKit

class AlertService {
    
    func alert(body: String) -> AlertViewController {
        
        // don't know if bundle is right??
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        
        // Set body text
        
        alertVC.alertBody = body
        
        return alertVC
    }
}
