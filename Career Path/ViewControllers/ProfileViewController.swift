//
//  ProfileViewController.swift
//  Career Path
//
//  Created by iosdev on 20/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var profileTableView: UITableView!

    //Placeholder user information
    private var user: User = User("Firstname ", "Lastname", "password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //button "menu"
        addSlideMenuButton()
        self.title = "Profile"
        self.nameLabel.text = user.username
        self.ageLabel.text = String(user.email)
        profileTableView.delegate = self as UITableViewDelegate
        profileTableView.dataSource = self as UITableViewDataSource
        profileTableView.tableFooterView = UIView()
        
    }
    
    //MARK: Actions

    @IBAction func locationButtonAction(_ sender: Any) {
        NetworkRequest().fetchGetUsers{data in print(data)}
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ProfileTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProfileTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProfileTableViewCell.")
        }
        // Fetches the appropriate menu_item for the data source layout.
       
        cell.img.image = UIImage(named:"profession_image")
        cell.name.text = "Manager"
        /*
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        */
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let careerListViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CareerList")
        
        self.navigationController?.pushViewController(careerListViewController, animated: true)
      
    }
 
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        profileImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    // when user press button "Select image"
    @IBAction func selectImageFromLibrary(_ sender: UIButton) {
       
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    //location - is it necessary?
    
    
    func loadUserInfo() {
        
        
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
