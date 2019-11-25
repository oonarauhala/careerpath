//
//  CareerListViewController.swift
//  Career Path
//
//  Created by iosdev on 22/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit
import CoreData

// The controller for the Scene that contains a TableView of Careers

class CareerListViewController: UIViewController {
    
    var fetchedResultsController: NSFetchedResultsController<CareerEntity>?
    
    @IBOutlet weak var tableView: UITableView!
    
    let request = NetworkRequest()
    var careers = [Career]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let fetchRequest: NSFetchRequest<CareerEntity> = CareerEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistenceService.context, sectionNameKeyPath: nil, cacheName: nil)

        
        fetchedResultsController!.delegate = self as NSFetchedResultsControllerDelegate
        try? fetchedResultsController?.performFetch()
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowInfo", let destination = segue.destination as? CareerInfoViewController {
            if let cell = sender as? CareerListCell, let indexPath = tableView.indexPath(for: cell) {
                destination.career = self.fetchedResultsController?.object(at: indexPath).convertToCareer()
            }
        }
    }
    
    //MARK: Private functions
    
    private func fetchFromContext() {
        let fetchRequest: NSFetchRequest<CareerEntity> = CareerEntity.fetchRequest()
        
        do {
            let careerEntities = try PersistenceService.context.fetch(fetchRequest)
            if careerEntities.count > 0
            {
                for ce in careerEntities {
                    let career = ce.convertToCareer()
                    careers.append(career)
                }
                self.tableView.reloadData()
            }
        }
        catch {}
    }
    
    // Loads all the careers from a backend API
    private func fetchData() {
        request.fetchCareers { (f) in
            // and compares them with the existing context in Core Data
            PersistenceService.compareCareerContext(responseArray: f)
            // compareCareerContext creates a new entity if one doesn't exist
        }
    }
}

// MARK: TableView Delegates

extension CareerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController!.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController!.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let careerEntity = self.fetchedResultsController?.object(at: indexPath) else {
            fatalError("not found")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerListCell", for: indexPath) as! CareerListCell
        cell.populateCell(career: careerEntity.convertToCareer())
        
        return cell
    }

}

extension CareerListViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controllerDidChangeContent")
        tableView.reloadData()
    }
}
 
