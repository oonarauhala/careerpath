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

class CareerListViewController: BaseViewController {
    
// MARK: Properties
    
    let colorTheme: Themes = .t9
    let request = NetworkRequest()
    let fetchRequest: NSFetchRequest<CareerEntity> = CareerEntity.fetchRequest()
    
    var header: CareerListHeader!
    var fetchedResultsController: NSFetchedResultsController<CareerEntity>?
    // displayState defines what kind of Careers to display
    // -> set this in prepare for segue
    var displayState: DisplayState = .Default
    var existingCareers: [Career]?
    var results: TestResults?
    
    private var sortedBySalaryAscending = true
    private var sortedByNameAscending = true
    private var sortedByDegreeAscending = true
    
// MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
// MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        tableViewSetup()
        colorSetup(theme: .t9)
        
        if displayState == .Default {
            defaultSetup()
        }
        else if displayState == .FutureDemand {
            futureDemandSetup()
        }
        else if displayState == .Results {
            testResultsSetup()
        }
        fetchData()
        
        self.title = "List of all careers"
        // for default navigation bar title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "#007BFFff") ?? UIColor.white]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        //print(scrollView.contentOffset.y)
//        if headerCurrentHeight == headerMaxHeightConstant {
//            if scrollView.contentOffset.y >= 285 {
//                // The magical number 285.
//                // This is where the header lets go of its place (currently)
//                // in the TableView, so the next time it is instantiated
//                // -> all it's content will be hidden, so need to
//                // update its height here as well
//                forceCollapseSortSelection()
//            }
//        }
//    }
    
// MARK: Initializer methods
    
    fileprivate func colorSetup(theme: Themes) {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.barTintColor = UIColor.navigationBar(theme: colorTheme)
        navBar.isTranslucent = true
        view.backgroundColor = UIColor.careerListView(theme: colorTheme)
        tableView.backgroundColor = UIColor.careerListBackground(theme: colorTheme)
    }
    
//----------------------<MAIN INITIALIZER >-------------------------------------------
    
//--> Used every time when the TableView is initialized or it's display style changes
    
    private func initFectchedResultsController(
        sortingKey: String, ascending: Bool, state: DisplayState)
    {
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: sortingKey, ascending: ascending)]
        
        // -> When navigated to this controller from home/navigation pressing "Future jobs"
        if state == .FutureDemand {
            fetchRequest.predicate = NSPredicate(format: "demand == %d", Int16(2))
        }
        // -> When navigated to this controller when showing careers based on test results
        else if state == .Results {
            guard let res = results else {
                fatalError("CareerListViewController.results not defined in segue")
            }
            fetchRequest.predicate = NSPredicate(format: "personalityType == %d", Int16(res.personalityType.convertToInt()))
        }
        // -> When navigated to this controller already knowing a set of career names
        else if state == .ExistingCareers {
            guard let careers = existingCareers else {
                fatalError("CareerListViewController.existingCareers not set")
            }
            var predicateString = "name == "
            if (careers.count > 0) {
                // This for loop iterates over the Career results defined in the segue
                // after career test and converts them into a string combined with
                // OR logic so it can be used as an NSPredicate
                for i in 0..<careers.count {
                    // Add Logical OR at the end of the string if not the last element in the array
                    if i < (careers.count - 1) {
                        predicateString = predicateString + "\"\(careers[i].careerName)\"" + " OR name == "
                    } else {
                        // At the end of the array here, so only appending the careerName at the end
                        predicateString = predicateString + "\"\(careers[i].careerName)\""
                    }
                }
            }
            fetchRequest.predicate = NSPredicate(format: predicateString)
        }
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceService.context,
            sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController!.delegate = self as NSFetchedResultsControllerDelegate
        try? fetchedResultsController?.performFetch()
    }
//----------------------</MAIN INITIALIZER >-------------------------------------------
    
    // Display all careers
    func defaultSetup() {
        initFectchedResultsController(sortingKey: "name", ascending: true, state: displayState)
    }
    
    // Display careers with high future demand
    func futureDemandSetup() {
        initFectchedResultsController(sortingKey: "demand", ascending: true, state: displayState)
    }
    
    // Display careers based on test results (defined in prepare for segue)
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
    
// MARK: Private functions
    
    fileprivate func tableViewSetup() {
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        
        header = Bundle.main.loadNibNamed(
            "CareerListHeader", owner: self, options: nil)?.first as? CareerListHeader
        switch displayState {
        case .FutureDemand:
            header.headerTitle.text = "A list of careers with high future demand"
        case .Results:
            header.headerTitle.text = "Your results"
        default:
            header.headerTitle.text = "A list of all our careers"
        }
        header.sortByButton.addTarget(self, action: #selector(sortButtonClicked(_:)), for: .touchUpInside)
        header.salaryButton.addTarget(self, action: #selector(sortBySalary(_:)), for: .touchUpInside)
        header.degreeButton.addTarget(self, action: #selector(sortByDegree(_:)), for: .touchUpInside)
        header.alphabeticalButton.addTarget(self, action: #selector(sortByName(_:)), for: .touchUpInside)
    
        tableView.tableHeaderView = header
        // custom lifecycle hack ->
        header.initiliazed = true
        header.initialSetup(theme: colorTheme)
    }
    
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

// MARK: NSFetchedResultsControllerDelegate

extension CareerListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controllerDidChangeContent")
        tableView.reloadData()
    }
}

// MARK : Sorting

extension CareerListViewController {
    
    // ->Collapses the sorting selection
    //   used whenever tableview content updates
    //   and when the header view should collapse
    private func forceCollapseSortSelection() {
        header.sortByPressed()
        self.tableView.beginUpdates()
        self.view.layoutIfNeeded()
        self.tableView.endUpdates()
    }
    
    @objc func sortButtonClicked(_ sender: Any) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    @objc func sortBySalary(_ sender: UIButton) {
        sortedBySalaryAscending = !sortedBySalaryAscending
        initFectchedResultsController(sortingKey: "salary", ascending: sortedBySalaryAscending, state: displayState)
        forceCollapseSortSelection()
        sortedByDegreeAscending = true
        sortedByNameAscending = true
        tableView.reloadDataWithAnimation(!sortedBySalaryAscending)
        header.setButtonTitles(salaryAscending: sortedBySalaryAscending, degreeAscending: sortedByDegreeAscending, nameAscending: sortedByNameAscending)
    }
    
    @objc func sortByName(_ sender: UIButton) {
        sortedByNameAscending = !sortedByNameAscending
        initFectchedResultsController(sortingKey: "name", ascending: !sortedByNameAscending, state: displayState)
        forceCollapseSortSelection()
        sortedBySalaryAscending = true
        sortedByDegreeAscending = true
        tableView.reloadDataWithAnimation(!sortedByNameAscending)
        header.setButtonTitles(salaryAscending: sortedBySalaryAscending, degreeAscending: sortedByDegreeAscending, nameAscending: sortedByNameAscending)
    }
    
    // DEGREE NEEDS REFACTORING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    @objc func sortByDegree(_ sender: UIButton) {
        sortedByDegreeAscending = !sortedByDegreeAscending
        initFectchedResultsController(sortingKey: "degree", ascending: sortedByDegreeAscending, state: displayState)
        forceCollapseSortSelection()
        sortedBySalaryAscending = true
        sortedByNameAscending = true
        tableView.reloadDataWithAnimation(!sortedByDegreeAscending)
        header.setButtonTitles(salaryAscending: sortedBySalaryAscending, degreeAscending: sortedByDegreeAscending, nameAscending: sortedByNameAscending)
        
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
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let careerEntity = self.fetchedResultsController?.object(at: indexPath) else {
            fatalError("not found")
        }
        tableView.register(UINib(nibName: "CareerListCell", bundle: nil), forCellReuseIdentifier: "CareerCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerCell", for: indexPath) as! CareerListCell
        cell.populateCell(career: careerEntity.convertToCareer())
        cell.setStyles(theme: colorTheme, cell: cell)
        
        return cell
    }
}

//MARK: Animation extensions

extension UITableView {
    func reloadDataWithAnimation(_ sortAscending: Bool) {
        var direction = CATransitionSubtype.fromBottom
        if sortAscending {
            direction = .fromTop
        }
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.fillMode = CAMediaTimingFillMode.forwards
        transition.duration = 0.35
        transition.subtype = direction
        self.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
        // Update your data source here
        self.reloadData()
    }
    
    func getAllIndexPaths() -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        
        for i in 0..<self.numberOfSections {
            for j in 0..<self.numberOfRows(inSection: i) {
                indexPaths.append(IndexPath(row: j, section: i))
            }
        }
        return indexPaths
    }
}
