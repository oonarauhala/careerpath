//
//  CareerInfoViewController.swift
//  CareerPath
//
//  Created by mikael on 18/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//
// The controller for a single career scene
// Contains all there is to know about the selected career
// and presents it onto the scene

import UIKit

class CareerInfoViewController: UIViewController {
    
    //MARK: Properties
    
    var career: Career?
    // Views
    @IBOutlet weak var scrollView: UIScrollView!
    // Labels
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var educationTitleLabel: UILabel!
    //career image
    @IBOutlet weak var careerImg: UIImageView!
    // Custom
    private var showMore = false
    private var size = CGSize(width: 1200.0, height: 693.0)
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        toggleShowMore()
        
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.backgroundColor = .none
        self.navigationController?.navigationBar.setBackgroundImage(.none, for: .default)
     
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
            
        }
    }
 
    
    //MARK: Initializers
    
    func initialSetup() {
        guard let careerUnwrapped = career else {
            fatalError("Career not found from segue")
        }
        salaryLabel.text = "\(careerUnwrapped.salaryToString)"
        
        //image resizing
        let careerImage =  resizeImage(image: UIImage(named: careerUnwrapped.careerName)!, targetSize: size)
        //text to image
        careerImg.image = textToImage(drawText: careerUnwrapped.careerName, inImage: careerImage, atPoint: CGPoint(x:145, y:600))
        /*
        let coverLayer = CALayer()
        coverLayer.frame = careerImg.bounds
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.3
        careerImg.layer.addSublayer(coverLayer)
      */
        descriptionLabelSetup(c: careerUnwrapped)
        educationLabelSetup(c: careerUnwrapped)
        
    
    }
    
    func descriptionLabelSetup(c: Career) {
        descriptionLabel.text = c.description
    }
    
    func educationLabelSetup(c: Career) {
        educationLabel.text = c.educationRequirement.rawValue
        educationLabel.textColor = .blue
        // create a gesture recognizer
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.showEducationInfo))
        // add it to the education label
        educationLabel.addGestureRecognizer(labelTapGesture)
    }
    
    //MARK: Actions
    
    @IBAction func showMorePressed(_ sender: UIButton) {
        showMore = !showMore
        toggleShowMore()
    }
    
    //MARK: Private Functions
    
    // Has the description label display only a certain number of lines when collapsed
    private func toggleShowMore() {
        if (!showMore) {
            descriptionLabel.numberOfLines = 10
            showMoreButton.setTitle("show more...", for: .normal)
            scrollView.setContentOffset(.zero, animated: false)
        } else {
            descriptionLabel.numberOfLines = 0
            showMoreButton.setTitle("show less...", for: .normal)
        }
    }
    
    @objc private func showEducationInfo() {
        guard let careerUnwrapped = career else {
            fatalError("Career not found from segue")
        }
        let careerDsc = careerUnwrapped.educationRequirement.description()
        let alert = UIAlertController(
            title: careerUnwrapped.educationRequirement.rawValue,
            message: careerDsc, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    //fuction for resizing image and function "textToimage" -> career name to image
    //1
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.black
        let textFont = UIFont(name: "Helvetica Bold", size: 50)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    
    }
    //2
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    
    
}


