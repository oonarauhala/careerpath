//
//  ProfileViewController.swift
//  Career Path
//
//  Created by iosdev on 20/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    //Placeholder user information
    private var user: User = User("placeholder firstname", "placeholder lastname", 20)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.nameLabel.text = user.firstName + user.lastName
        self.ageLabel.text = String(user.age)
        
        self.view.backgroundColor = UIColor(red: 0, green: 0.7176, blue: 0.7059, alpha: 1.0) 
    }
    
    @IBAction func locationBtn(_ sender: Any) {
        loadUserInfo()
    }
    
    func loadUserInfo() {
        let test = NetworkRequest()
        
        test.fetchGetUser(userID: "1")
        
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
