//
//  CareerListHeader.swift
//  Career Path
//
//  Created by mikael on 30/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

class CareerListHeader: UITableViewCell {
    
    // MARK: Properties
    
    private var pickerIsHidden: Bool = true
    
    var selections = ["Salary", "Name", "Education required"]
    var pickerViewOptions = [1,2,3,4]
    
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var headerContainer: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialSetup(title: String) {
        headerTitle.text = title
    }
    
//    @IBAction func hideShowSortOptions(_ sender: Any) {
//        pickerView.isHidden = !pickerIsHidden
//        pickerIsHidden = !pickerIsHidden
//
//    }
}

extension CareerListHeader: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewOptions.count
    }
}
