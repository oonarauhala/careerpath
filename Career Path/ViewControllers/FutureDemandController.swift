//
//  FutureDemandController.swift
//  Career Path
//
//  Created by mikael on 30/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

// A controller for manually performing a segue to CareerListViewController,
// changing it's displayState, so that it displays only Careers that
// have high future demand

class FutureDemandController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "FutureDemand", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FutureDemand", let destination = segue.destination as? CareerListViewController {
            destination.displayState = .FutureDemand
        }
    }
}
