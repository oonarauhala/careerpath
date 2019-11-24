//
//  CareerListViewController.swift
//  Career Path
//
//  Created by iosdev on 22/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

// The controller for the Scene that contains a TableView of Careers

class CareerListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let request = NetworkRequest()
    var careers = [Career]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Private functions
    
    // Loads all the careers from a backend API
    // and sets to the tableView's dataSource
    private func fetchData() {
        request.fetchCareers { (f) in
            for result in f {
                let converted = result.convertToCareer()
                self.careers.append(converted)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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

extension CareerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return careers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let career = careers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerListCell") as! CareerListCell
        cell.populateCell(career: career)
        
        return cell
    }

}
 
