//
//  CareerListViewController.swift
//  Career Path
//
//  Created by mikael on 22/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit
import CoreData

// The controller for scenes that contains a TableView of Careers
// the content can be either default, which is every single career,
// or only the careers that have high future demand.

// Populates the TableView with data from CoreData
// automatically, using NSFetchedResultsControllerDelegate

class CareerListViewController: UIViewController {
    
    // MARK: Properties
    
    let request = NetworkRequest()
    var fetchedResultsController: NSFetchedResultsController<CareerEntity>?
    private var sortedBySalaryAscending = true
    // displayState defines what kind of Careers to display
    // -> set this in prepare for segue
    var displayState: DisplayState = .Default

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonSetup()
        
        if displayState == .Default {
            defaultSetup()
        }
        else if displayState == .FutureDemand {
            futureDemandSetup()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: Initializer methods
    
    func commonSetup() {
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Display all careers
    func defaultSetup() {
        let fetchRequest: NSFetchRequest<CareerEntity> = CareerEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceService.context,
            sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController!.delegate = self as NSFetchedResultsControllerDelegate
        try? fetchedResultsController?.performFetch()
        
        fetchData()
    }
    
    // Display careers with high future demand
    func futureDemandSetup() {
        let fetchRequest: NSFetchRequest<CareerEntity> = CareerEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        // demand is an Int16 value from 0..2 -> representing: Low, Medium, High
        fetchRequest.predicate = NSPredicate(format: "demand == %d", Int16(2))
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceService.context,
            sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController!.delegate = self as NSFetchedResultsControllerDelegate
        try? fetchedResultsController?.performFetch()
        
        fetchData()
    }
    
    // MARK: Actions
    
    @objc func sortButtonClicked(_ sender: Any) {
        sortBySalary()
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowInfo",
            let destination = segue.destination as? CareerInfoViewController {
            
            if let cell = sender as? Career {
                destination.career = cell
            } else {
                fatalError("Segue sender not a Career, aborting mission!")
            }
        }
    }
    
    //MARK: Private functions
    
    // -> Loads all the careers from a backend API
    private func fetchData() {
        do {
            try request.fetchCareers { (f) in
                // and compares them with the existing context in Core Data
                PersistenceService.compareCareerContext(responseArray: f)
                // compareCareerContext creates a new entity if one doesn't exist
            }
        }
        catch {
            print(error)
        }
    }
    
    func sortBySalary() {
        sortedBySalaryAscending = !sortedBySalaryAscending
        
        let fetchRequest: NSFetchRequest<CareerEntity> = CareerEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "salary", ascending: sortedBySalaryAscending)]
        
        if displayState == .FutureDemand {
            fetchRequest.predicate = NSPredicate(format: "demand == %d", Int16(2))
        }
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceService.context,
            sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController!.delegate = self as NSFetchedResultsControllerDelegate
        try? fetchedResultsController?.performFetch()
        
        tableView.reloadData()
    }
}

// MARK: TableView Delegates

extension CareerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController!.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
     //viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("CareerListHeader", owner: self, options: nil)?.first as! CareerListHeader
        
        switch displayState {
            case .Default:
                header.initialSetup(title: "A list of all our careers")
            case .FutureDemand:
                header.initialSetup(title: "A list of careers with high future demand")
            }
        // This action currently sorts Careers by salary only
        header.sortButton.addTarget(self, action: #selector(self.sortButtonClicked(_:)), for: .touchUpInside)
        
        return header
    }
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let careerEntity = self.fetchedResultsController?.object(at: indexPath) else {
            fatalError("not found")
        }
        self.performSegue(withIdentifier: "ShowInfo", sender: careerEntity.convertToCareer())
    }
    
    // numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController!.sections?.count ?? 1
    }
    
    // heightForHeaderInSection
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Needs to be set to CareerListHeader's height when it's fully implemented
        return 50
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let careerEntity = self.fetchedResultsController?.object(at: indexPath) else {
            fatalError("not found")
        }
        tableView.register(UINib(nibName: "CareerListCell", bundle: nil), forCellReuseIdentifier: "CareerCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerCell", for: indexPath) as! CareerListCell
        cell.populateCell(career: careerEntity.convertToCareer())
        
        return cell
    }

}

//MARK: NSFetchedResultsControllerDelegate

extension CareerListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controllerDidChangeContent")
        tableView.reloadData()
    }
}
 
