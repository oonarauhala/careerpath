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
// only the careers that have high future demand, or test results.

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
    var results: TestResults?
    // data is the tableView's data source. The same data as in fethcedResultsController
    // but for sorting purposes, it needs to be in a mutable form.
    // (apparently, can not make an NSSortDescriptor for sort predicates outside the entity..?)
    var data = [CareerEntity]()
    
    private var sortedBySalaryAscending = false
    private var sortedByNameAscending = false
    private var sortedByDegreeAscending = false
    private var sortedBySuitabilityAscending = false
    private var salaryNeedsSorting = false
    private var nameNeedsSorting = false
    private var degreeNeedsSorting = false
    private var suitabilityNeedsSorting = true
    
// MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
// MARK: Lifecycle methods
    
    //viewDidLoad
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
    }
    
    //viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
//MARK: Navigation
    
    
//MARK: Actions
    
    @IBAction func registerLogin(_ sender: Any) {
        performSegue(withIdentifier: "ResultsRegisterLogin", sender: self)
    }
    
// MARK: Initializer methods
    
    fileprivate func colorSetup(theme: Themes) {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.barTintColor = UIColor.navigationBar(theme: colorTheme)
        navBar.isTranslucent = true
        view.backgroundColor = UIColor.careerListView(theme: colorTheme)
        tableView.backgroundColor = UIColor.careerListBackground(theme: colorTheme)
    }
    
    fileprivate func tableViewSetup() {
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        headerSetup()
    }
    
    fileprivate func headerSetup() {
        header = Bundle.main.loadNibNamed(
            "CareerListHeader", owner: self, options: nil)?.first as? CareerListHeader
        
        switch displayState {
            case .FutureDemand:
                self.title = "Careers with high future demand"
            case .Results:
                self.title = "Your results"
            default:
                self.title = "List of all careers"
        }
        if (displayState == .Results) {
            header.isResults = true
        }
        header.sortByButton.addTarget(self, action: #selector(sortButtonClicked(_:)), for: .touchUpInside)
        header.salaryButton.addTarget(self, action: #selector(sortBySalary(_:)), for: .touchUpInside)
        header.degreeButton.addTarget(self, action: #selector(sortByDegree(_:)), for: .touchUpInside)
        header.alphabeticalButton.addTarget(self, action: #selector(sortByName(_:)), for: .touchUpInside)
        header.suitabilityButton.addTarget(self, action: #selector(sortBySuitability(_:)), for: .touchUpInside)
        header.setButtonTitles(salaryAscending: sortedBySalaryAscending, degreeAscending: sortedByDegreeAscending, nameAscending: sortedByNameAscending, suitabilityAscending: sortedBySuitabilityAscending)
        tableView.tableHeaderView = header
        header.initiliazed = true
        header.initialSetup(theme: colorTheme)
    }
    
    // Display all careers
    func defaultSetup() {
        nameNeedsSorting = true
        sortedByNameAscending = true
        initFectchedResultsController(sortingKey: "name", ascending: true, state: displayState)
    }
    
    // Display careers with high future demand
    func futureDemandSetup() {
        nameNeedsSorting = true
        sortedByNameAscending = true
        initFectchedResultsController(sortingKey: "demand", ascending: true, state: displayState)
    }
    
    // Display careers based on test results (defined in prepare for segue)
    func testResultsSetup() {
        checkIsLoggedIn()
        suitabilityNeedsSorting = true
        sortedBySuitabilityAscending = true
        initFectchedResultsController(sortingKey: "personalityType", ascending: true, state: displayState)
        
        if !PersistenceService.checkUserLoggedIn() {
            bottomToolBar.isHidden = false
        }
    }
    
    //--> The main initializer that sets up the fetchedResultsController
    private func initFectchedResultsController(sortingKey: String, ascending: Bool, state: DisplayState) {
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: sortingKey, ascending: ascending)]
        
        // -> When navigated to this controller from home/navigation pressing "Future jobs"
        if state == .FutureDemand {
            fetchRequest.predicate = NSPredicate(format: "demand == %d", Int16(2))
        }
            
        // -> When navigated to this controller when showing careers based on test results
        else if state == .Results {
            guard let res = results else {
                fatalError("Results not initialized in segue to CareerListViewController")
            }
            // Setting the first 3 components of a personality type as an NSPredicate
            // the number of components can be changed -> Lower (more results) or -> Higher (less results)
            let personalityTypeComponents = res.personalityType.getComponents()
            let component1 = personalityTypeComponents[0].convertToInt()
            let component2 = personalityTypeComponents[1].convertToInt()
            let component3 = personalityTypeComponents[2].convertToInt()

            // should return all careers of which personality types start with 3 of the same components
            // for example, personalityType: "ESTP" returns careers for personality types: ESTP & ESTJ
            let keywordsPredicate1 = NSPredicate(format: "keyword1 == %d", Int16(component1))
            let keywordsPredicate2 = NSPredicate(format: "keyword2 == %d", Int16(component2))
            let keywordsPredicate3 = NSPredicate(format: "keyword3 == %d", Int16(component3))
            
            let compoundPredicate = NSCompoundPredicate(
                andPredicateWithSubpredicates: [keywordsPredicate1, keywordsPredicate2, keywordsPredicate3])
            
            fetchRequest.predicate = compoundPredicate
            print("Career fetch predicate: \(compoundPredicate)")
        }
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceService.context,
            sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController!.delegate = self as NSFetchedResultsControllerDelegate
        try? fetchedResultsController?.performFetch()
    }
    
// MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowInfo",
            let destination = segue.destination as? CareerInfoViewController {
            
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                destination.career = self.data[selectedRow].convertToCareer()
            } else {
                fatalError("Segue sender not a Career, aborting mission!")
            }
        }
        else if segue.identifier == "ResultsRegisterLogin",let destination = segue.destination as? RegisterViewController {
            destination.isFromResults = true
            destination.resultsPersonalityType = results?.personalityType
            print("results personalitytype: ", results?.personalityType ?? "not found")
        }
    }
    
// MARK: Private functions
    
    // Saves the test results when the user is logged in
    private func saveData() {
        if displayState == .Results {
            guard var res = results else { fatalError("no results found") }
            PersistenceService.saveUserToDefaults(username: res.user.username, email: res.user.email, results: res.personalityType.convertToInt())
            res.user.testResults.append(res.personalityType.convertToInt())
            // saves a new user or updates an existing one
            PersistenceService.saveUserToBackEnd(user: res.user)
        }
    }
    
    private func checkIsLoggedIn() {
        if PersistenceService.checkUserLoggedIn() {
            saveData()
        }
    }

//    private func saveData() {
//        if displayState == .Results {
//            if isLoggedIn {
//                guard let res = results else { fatalError("no results found") }
//                PersistenceService.saveTestResults(type: res.personalityType)
//            }
//        }
//    }
//
//    private func checkIsLoggedIn() {
//        if isLoggedIn {
//            saveData()
//        } else {
//            // saveButton.isHidden = false
//        }
//    }
    
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

// MARK : Sorting

extension CareerListViewController {
    
    private func sorted() {
        header.setButtonTitles(salaryAscending: sortedBySalaryAscending, degreeAscending: sortedByDegreeAscending, nameAscending: sortedByNameAscending, suitabilityAscending: sortedBySuitabilityAscending)
        self.tableView.beginUpdates()
        self.view.layoutIfNeeded()
        self.tableView.endUpdates()
    }
    
    @objc func sortButtonClicked(_ sender: Any) {
        header.setButtonTitles(salaryAscending: sortedBySalaryAscending, degreeAscending: sortedByDegreeAscending, nameAscending: sortedByNameAscending, suitabilityAscending: sortedBySuitabilityAscending)
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    @objc func sortBySalary(_ sender: UIButton) {
//        initFectchedResultsController(sortingKey: "salary", ascending: sortedBySalaryAscending, state: displayState)
        salaryNeedsSorting = true
        suitabilityNeedsSorting = false
        degreeNeedsSorting = false
        nameNeedsSorting = false
        sortedByNameAscending = false
        sortedByDegreeAscending = false
        sortedByNameAscending = false
        sortedBySuitabilityAscending = false
        sortedBySalaryAscending = !sortedBySalaryAscending
        tableView.reloadDataWithAnimation(sortedBySalaryAscending)
        sorted()
    }
    
    @objc func sortByName(_ sender: UIButton) {
        //initFectchedResultsController(sortingKey: "name", ascending: !sortedByNameAscending, state: displayState)
        nameNeedsSorting = true
        degreeNeedsSorting = false
        salaryNeedsSorting = false
        suitabilityNeedsSorting = false
        sortedBySalaryAscending = false
        sortedBySuitabilityAscending = false
        sortedByDegreeAscending = false
        sortedByNameAscending = !sortedByNameAscending
        tableView.reloadDataWithAnimation(sortedByNameAscending)
        sorted()
    }
    
    @objc func sortByDegree(_ sender: UIButton) {
        //initFectchedResultsController(sortingKey: "degree", ascending: sortedByDegreeAscending, state: displayState)
        degreeNeedsSorting = true
        salaryNeedsSorting = false
        nameNeedsSorting = false
        suitabilityNeedsSorting = false
        sortedBySalaryAscending = false
        sortedByNameAscending = false
        sortedBySuitabilityAscending = false
        sortedByDegreeAscending = !sortedByDegreeAscending
        tableView.reloadDataWithAnimation(sortedByDegreeAscending)
        sorted()
    }
    
    @objc func sortBySuitability(_ sender: UIButton) {
        //initFectchedResultsController(sortingKey: "degree", ascending: sortedByDegreeAscending, state: displayState)
        suitabilityNeedsSorting = true
        degreeNeedsSorting = false
        salaryNeedsSorting = false
        nameNeedsSorting = false
        sortedBySalaryAscending = false
        sortedByNameAscending = false
        sortedByDegreeAscending = false
        sortedBySuitabilityAscending = !sortedBySuitabilityAscending
        tableView.reloadDataWithAnimation(sortedByDegreeAscending)
        sorted()
    }
    
    fileprivate func sortData() {
        if displayState == .Results {
            // Sorting for results
            if suitabilityNeedsSorting {
                data = data.sorted { (lh: CareerEntity, rh: CareerEntity) -> Bool in
                    if sortedBySuitabilityAscending {
                        return lh.convertToCareer().personalityType == results!.personalityType
                    } else {
                        return rh.convertToCareer().personalityType == results!.personalityType
                    }
                }
            }
        }
        if degreeNeedsSorting {
            data = data.sorted { (lh: CareerEntity, rh: CareerEntity) -> Bool in
                if sortedByDegreeAscending {
                    return lh.degree > rh.degree
                } else {
                    return lh.degree < rh.degree
                }
            }
        }
        if nameNeedsSorting {
            data = data.sorted { (lh: CareerEntity, rh: CareerEntity) -> Bool in
                if sortedByNameAscending {
                    return lh.name! < rh.name!
                } else {
                    return lh.name! > rh.name!
                }
            }
        }
        if salaryNeedsSorting {
            data = data.sorted { (lh: CareerEntity, rh: CareerEntity) -> Bool in
                if sortedBySalaryAscending {
                    return lh.salary > rh.salary
                } else {
                    return lh.salary < rh.salary
                }
            }
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
        guard let careerEntities = self.fetchedResultsController?.fetchedObjects else {
            fatalError("Career entities not found from fetchedResultsController")
        }
        // converting the fetchedObjects into a mutable collection -> data
        data = careerEntities
        // so it can be sorted in sortData()
        if degreeNeedsSorting || salaryNeedsSorting || nameNeedsSorting || suitabilityNeedsSorting {
            sortData()
        }
        let careerEntity = data[indexPath[1]]
        
        tableView.register(UINib(nibName: "CareerListCell", bundle: nil), forCellReuseIdentifier: "CareerCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerCell", for: indexPath) as! CareerListCell
        let career = careerEntity.convertToCareer()
        
        // 3 lines below are related to only: self.displayState == .Results
        var isResults = false
        var suitabilityBarValue: Float = 0.5
        let mostSuitable: Float = 4 // <--- Most suitable career is when all (four) personality type components match
        
        if displayState == .Results {
            if let resultComponents = results {
                career.calculateSuitability(&suitabilityBarValue, mostSuitable, &isResults, resultComponents)
            } else {
                print("results?.keywords failed")
            }
        }
        // using the default values defined above, so that the cell can be
        // instantiated whether or not self.displayState == .Results
        cell.populateCell(career: career, isResult: isResults, progress: suitabilityBarValue)
        cell.setStyles(theme: colorTheme, cell: cell)

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
