//
//  AlertViewController.swift
//  Career Path
//
//  Created by Oona on 24/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

// Controller for alerts
// Made with tutorial found here: https://www.youtube.com/watch?v=NP7H_LjTZGw

class AlertViewController: UIViewController {
    
    @IBAction func cancelButton(_ sender: RoundButton) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var body: UILabel!
    
    var alertBody = String()
    
    func setupView() {
        body.text = alertBody
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

