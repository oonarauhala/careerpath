//
//  NoResultsController.swift
//  Career Path
//
//  Created by iosdev on 10/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class NoResultsController: UIViewController {
    
    
    @IBOutlet weak var noResultsButton: UIButton!
    @IBOutlet weak var noResultsTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noResultsButton.backgroundColor = UIColor.sortingButtons(theme: .t9)
        noResultsButton.setTitleColor(UIColor.white, for: .normal)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
