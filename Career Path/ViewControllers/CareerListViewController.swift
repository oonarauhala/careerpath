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
    
// MARK: Lifecycle methods
    
    override func viewDidLoad() {
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable") // <--- <3
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
// MARK: Initializer methods
    
    fileprivate func colorSetup(theme: Themes) {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.barTintColor = UIColor.navigationBar(theme: colorTheme)
        navBar.isTranslucent = true
        view.backgroundColor = UIColor.careerListView(theme: colorTheme)
        tableView.backgroundColor = UIColor.careerListBackground(theme: colorTheme)
    }
    
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
                fatalError("Results not initialized in segue to CareerListViewController")
            }
            // Setting the first 3 components of a personality type as an NSPredicate
            // the number of components can be changed -> Lower (more results) or -> Higher (less results)
            let personalityTypeComponents = res.personalityType.getComponents()
            let component1 = personalityTypeComponents[0].convertToInt()
            let component2 = personalityTypeComponents[1].convertToInt()
            let component3 = personalityTypeComponents[2].convertToInt()

            // should return all careers stat start with 3 of the same components
            // for example, personalityType: "ESTP" returns careers for personality types: ESTP & ESTJ
            let keywordsPredicate1 = NSPredicate(format: "keyword1 == %d", Int16(component1))
            let keywordsPredicate2 = NSPredicate(format: "keyword2 == %d", Int16(component2))
            let keywordsPredicate3 = NSPredicate(format: "keyword3 == %d", Int16(component3))
            
            let compoundPredicate = NSCompoundPredicate(
                andPredicateWithSubpredicates: [keywordsPredicate1, keywordsPredicate2, keywordsPredicate3])
            
            fetchRequest.predicate = compoundPredicate
            print("Predicate: \(compoundPredicate)")
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
    
    // Display all careers
    func defaultSetup() {
        sortedByNameAscending = true
        initFectchedResultsController(sortingKey: "name", ascending: true, state: displayState)
    }
    
    // Display careers with high future demand
    func futureDemandSetup() {
        sortedByNameAscending = true
        initFectchedResultsController(sortingKey: "demand", ascending: true, state: displayState)
    }
    
    // Display careers based on test results (defined in prepare for segue)
    func testResultsSetup() {
        // personalityType == \(results!.personalityType.convertToInt())
        sortedBySuitabilityAscending = true
        initFectchedResultsController(sortingKey: "personalityType", ascending: true, state: displayState)
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
            header.headerTitle.text = ""
        case .Results:
            header.headerTitle.text = ""
        default:
            header.headerTitle.text = ""
        }
 
        header.sortByButton.addTarget(self, action: #selector(sortButtonClicked(_:)), for: .touchUpInside)
        header.salaryButton.addTarget(self, action: #selector(sortBySalary(_:)), for: .touchUpInside)
        header.degreeButton.addTarget(self, action: #selector(sortByDegree(_:)), for: .touchUpInside)
        header.alphabeticalButton.addTarget(self, action: #selector(sortByName(_:)), for: .touchUpInside)
        header.setButtonTitles(salaryAscending: sortedBySalaryAscending, degreeAscending: sortedByDegreeAscending, nameAscending: sortedByNameAscending)
    
        tableView.tableHeaderView = header
        // custom lifecycle hack ->
        header.initiliazed = true
        header.initialSetup(theme: colorTheme)
    }
    
    // -> Calculates the career suitability when in test results
    fileprivate func calculateSuitability(_ career: Career, _ suitabilityBarValue: inout Float, _ mostSuitable: Float, _ isResults: inout Bool) {
        // personalityType.getComponents() splits the personality type into its singular components
        let currentComponents = career.personalityType.getComponents()
        var suitability = 0
        // the test results have a property for the specified personality type,
        // so comparing every career's personality type to its components
        if let resultComponents = results?.keywords {
            for keyword in resultComponents {
                for component in currentComponents {
                    if keyword.type == component {
                        suitability += 1 // <--- +1 point in suitability if a component matches
                    }
                }
            }
        } else {
            print("results?.keywords failed")
        }
        print("Career: \(career.careerName) Suitability: \(suitability) PersonalityType: \(career.personalityType)")
        
        suitabilityBarValue = Float(suitability) / mostSuitable
        isResults = true
        print("Results personalityType: \(results!.personalityType)")
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
//        initFectchedResultsController(sortingKey: "salary", ascending: sortedBySalaryAscending, state: displayState)
        salaryNeedsSorting = true
        suitabilityNeedsSorting = false
        degreeNeedsSorting = false
        nameNeedsSorting = false
        sortedByNameAscending = false
        sortedByDegreeAscending = false
        sortedByNameAscending = false
        sortedBySalaryAscending = !sortedBySalaryAscending
        header.setButtonTitles(salaryAscending: sortedBySalaryAscending, degreeAscending: sortedByDegreeAscending, nameAscending: sortedByNameAscending)
        tableView.reloadDataWithAnimation(sortedBySalaryAscending)
        forceCollapseSortSelection()
    }
    
    @objc func sortByName(_ sender: UIButton) {
//        initFectchedResultsController(sortingKey: "name", ascending: !sortedByNameAscending, state: displayState)
        nameNeedsSorting = true
        degreeNeedsSorting = false
        salaryNeedsSorting = false
        suitabilityNeedsSorting = false
        sortedBySalaryAscending = false
        sortedBySuitabilityAscending = false
        sortedByDegreeAscending = false
        sortedByNameAscending = !sortedByNameAscending
        header.setButtonTitles(salaryAscending: sortedBySalaryAscending, degreeAscending: sortedByDegreeAscending, nameAscending: sortedByNameAscending)
        tableView.reloadDataWithAnimation(sortedByNameAscending)
        forceCollapseSortSelection()
    }
    
    @objc func sortByDegree(_ sender: UIButton) {
//        initFectchedResultsController(sortingKey: "degree", ascending: sortedByDegreeAscending, state: displayState)
        degreeNeedsSorting = true
        salaryNeedsSorting = false
        nameNeedsSorting = false
        suitabilityNeedsSorting = false
        sortedBySalaryAscending = false
        sortedByNameAscending = false
        sortedBySuitabilityAscending = false
        sortedByDegreeAscending = !sortedByDegreeAscending
        header.setButtonTitles(salaryAscending: sortedBySalaryAscending, degreeAscending: sortedByDegreeAscending, nameAscending: sortedByNameAscending)
        tableView.reloadDataWithAnimation(sortedByDegreeAscending)
        forceCollapseSortSelection()
        
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
        data = careerEntities
        
        if degreeNeedsSorting || salaryNeedsSorting || nameNeedsSorting || suitabilityNeedsSorting {
            sortData()
        }
        let careerEntity = data[indexPath[1]]
        
        tableView.register(UINib(nibName: "CareerListCell", bundle: nil), forCellReuseIdentifier: "CareerCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerCell", for: indexPath) as! CareerListCell
        let career = careerEntity.convertToCareer()
        
        // 3 lines below are related to only displayState == .Results
        var isResults = false
        var suitabilityBarValue: Float = 0.5
        let mostSuitable: Float = 4 // <--- Most suitable career is when all (four) personality type components match
        
        if displayState == .Results {
            calculateSuitability(career, &suitabilityBarValue, mostSuitable, &isResults)
        }
        
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
