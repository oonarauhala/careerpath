//
//  ProfileViewController.swift
//  Career Path
//
//  Created by iosdev on 20/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:Properties
    let colorTheme: Themes = .t9
    
    //MARK: labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var personalityTypeHeader: UILabel!
    @IBOutlet weak var personalityType: UILabel!
    @IBOutlet weak var recommendedJobsHeader: UILabel!
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var viewInScrollView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    
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
        profileTableView.tableFooterView = UIView(frame: CGRect.zero)
        colorSetup(theme: .t9)
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
        cell.careerNameLabel.text = "Career_name"
        cell.salaryLabel.text = "Salary"
        cell.degreeLabel.text = "Degree"
        cell.setStyles(theme: colorTheme, cell: cell)
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
    @IBAction func logout(_ sender: Any) {
        // logs out and clears the results from UserDefaults (sets nil)
        PersistenceService.clearUserDefaults()
    }
    
    //styling
    // better to change names of functions in UIColor extension
    fileprivate func colorSetup(theme: Themes) {
        profileTableView.backgroundColor = UIColor.viewBackground(theme: colorTheme)
        viewInScrollView.backgroundColor = UIColor.viewBackground(theme: colorTheme)
        personalityTypeHeader.textColor = UIColor.testHeaderAndQuestion(theme: colorTheme)
        recommendedJobsHeader.textColor = UIColor.testHeaderAndQuestion(theme: colorTheme)
        selectPhotoButton.setTitleColor(UIColor(hex:"#47A1F7ff"), for: .normal)
        logoutButton.backgroundColor = UIColor.testButtonsBackground(theme: colorTheme)
        logoutButton.setTitleColor(UIColor.testButtonsTitle(theme: colorTheme), for: .normal)
    }
    
    
    //location - is it necessary?
    func loadUserInfo() {
    }
}
