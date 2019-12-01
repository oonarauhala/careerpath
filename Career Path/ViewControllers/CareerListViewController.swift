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
    let fetchRequest: NSFetchRequest<CareerEntity> = CareerEntity.fetchRequest()
    
    var fetchedResultsController: NSFetchedResultsController<CareerEntity>?
    // displayState defines what kind of Careers to display
    // -> set this in prepare for segue
    var displayState: DisplayState = .Default
    var resultCareers = [Career]()

    private var sortedBySalaryAscending = true
    private var sortedByNameAscending = true
    private var sortedByDegreeAscending = true
    private var headerCurrentHeight: CGFloat = 50

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        if displayState == .Default {
            defaultSetup()
        }
        else if displayState == .FutureDemand {
            futureDemandSetup()
        }
        else if displayState == .Results {
            testResultsSetup()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.y)
        if headerCurrentHeight == 250 {
            if scrollView.contentOffset.y >= 285 {
                // The magical number 285.
                // This is where the header lets go of its place (currently)
                // in the TableView, so the next time it is instantiated
                // -> all it's content will be hidden, so need to
                // update its height here as well
                forceCollapseSortSelection()
            }
        }
    }
    
    // MARK: Initializer methods
    
    // -> Used every time when the TableView is initialized or it's display style changes
    private func initFectchedResultsController(sortingKey: String, ascending: Bool, state: DisplayState) {
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: sortingKey, ascending: ascending)]
        
        if state == .FutureDemand {
            fetchRequest.predicate = NSPredicate(format: "demand == %d", Int16(2))
        }
        else if state == .Results {
            var predicateString = "name == "
            if (resultCareers.count > 0) {
                // This for loop iterates over the Career results defined in the segue
                // after career test and converts them into a string appropriate for NSPredicate
                for i in 0..<resultCareers.count {
                    // Add Logical OR at the end of the string if not the last element in the array
                    if i < (resultCareers.count - 1) {
                        predicateString = predicateString + "\"\(resultCareers[i].careerName)\"" + " OR name == "
                    } else {
                        // At the end of the array here, so no need for another Logical OR
                        predicateString = predicateString + "\"\(resultCareers[i].careerName)\""
                    }
                }
            } else {
                fatalError("Trying to initiate CareerListViewController without setting the results in segue")
            }
            //print("Predicate string: ", predicateString)
            fetchRequest.predicate = NSPredicate(format: predicateString)
        }
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceService.context,
            sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController!.delegate = self as NSFetchedResultsControllerDelegate
        try? fetchedResultsController?.performFetch()
        
    } // --------------------End----initFetchedResultsController----------------------------------
    
    // Display all careers
    func defaultSetup() {
        initFectchedResultsController(sortingKey: "name", ascending: true, state: displayState)
    }
    
    // Display careers with high future demand
    func futureDemandSetup() {
        initFectchedResultsController(sortingKey: "demand", ascending: true, state: displayState)
    }
    
    func testResultsSetup() {
        initFectchedResultsController(sortingKey: "name", ascending: true, state: displayState)
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
            case .FutureDemand:
                header.initialSetup(title: "A list of careers with high future demand")
            case .Results:
                header.initialSetup(title: "Your results")
            default:
                header.initialSetup(title: "A list of all our careers")
            }
        header.sortByButton.addTarget(self, action: #selector(sortButtonClicked(_:)), for: .touchUpInside)
        header.salaryButton.addTarget(self, action: #selector(sortBySalary(_:)), for: .touchUpInside)
        header.degreeButton.addTarget(self, action: #selector(sortByDegree(_:)), for: .touchUpInside)
        header.alphabeticalButton.addTarget(self, action: #selector(sortByName(_:)), for: .touchUpInside)
        
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
        return headerCurrentHeight
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

// MARK: NSFetchedResultsControllerDelegate

extension CareerListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controllerDidChangeContent")
        tableView.reloadData()
    }
}

// MARK : Sorting

extension CareerListViewController {
    
    private func forceCollapseSortSelection() {
        headerCurrentHeight = 50
        self.tableView.beginUpdates()
        self.view.layoutIfNeeded()
        self.tableView.endUpdates()
    }
    
    @objc func sortButtonClicked(_ sender: Any) {
        self.tableView.beginUpdates()
        
        if headerCurrentHeight == 50 {
            headerCurrentHeight = 250
        } else {
            headerCurrentHeight = 50
        }
        self.view.layoutIfNeeded()
        self.tableView.endUpdates()
    }
    
    @objc func sortBySalary(_ sender: Any) {
        sortedBySalaryAscending = !sortedBySalaryAscending
        initFectchedResultsController(sortingKey: "salary", ascending: sortedBySalaryAscending, state: displayState)
        forceCollapseSortSelection()
        sortedByDegreeAscending = true
        sortedByNameAscending = true
        tableView.reloadData()
    }
    
    @objc func sortByName(_ sender: Any) {
        sortedByNameAscending = !sortedByNameAscending
        initFectchedResultsController(sortingKey: "name", ascending: !sortedByNameAscending, state: displayState)
        forceCollapseSortSelection()
        sortedBySalaryAscending = true
        sortedByDegreeAscending = true
        tableView.reloadData()
    }
    
    // DEGREE NEEDS REFACTORING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    @objc func sortByDegree(_ sender: Any) {
        sortedByDegreeAscending = !sortedByDegreeAscending
        initFectchedResultsController(sortingKey: "degree", ascending: sortedByDegreeAscending, state: displayState)
        forceCollapseSortSelection()
        sortedBySalaryAscending = true
        sortedByNameAscending = true
        tableView.reloadData()
    }
}
