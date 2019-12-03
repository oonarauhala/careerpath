//
//  MenuViewController.swift
//  Career Path
//
//  Created by iosdev on 01/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import UIKit

protocol  SlideMenuDelegate {
    func slideMenuSelectedAtIndex(_ index: Int32)
    }
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:variables
    
    //menu button which was tapped to display the menu
    var btnMenu: UIButton!
    //delegate of the MenuVC
    var delegate: SlideMenuDelegate?
    // menu items array
    var menuItems = [Item]()
    //MARK:labels
    @IBOutlet weak var tableView: UITableView!
    //transparent button to hide menu
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load all menu items
        loadSampleItems()
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        //removes empty cells from the table
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MenuTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MenuTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MenuTableViewCell.")
        }
        // Fetches the appropriate menu_item for the data source layout.
        let menuItem = menuItems[indexPath.row]
        cell.icon.image = menuItem.icon
        cell.menu_name.text = menuItem.name_item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = indexPath.row
        self.btnCloseTapped(btn)
    }
    
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        btnMenu.tag = 0
        btnMenu.isHidden = false
        if (self.delegate != nil) {
            var index = Int32(sender.tag)
            if(sender == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuSelectedAtIndex(index)
        
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
                self.view.layoutIfNeeded()
                self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParent()
            })
        }
    }

    //array for menu items
    func loadSampleItems() {
        
    let icon1 = UIImage(named: "icon1")
    let icon2 = UIImage(named: "icon2")
    let icon3 = UIImage(named: "icon3")
    let icon4 = UIImage(named: "icon4")
        
    let menuItem1 = Item(name_item: "Home", icon: icon1)
    let menuItem2 = Item(name_item: "Profile", icon: icon2)
    let menuItem3 = Item(name_item: "Browse jobs", icon: icon3)
    let menuItem4 = Item(name_item: "Take the test", icon: icon4)
    
    menuItems += [menuItem1, menuItem2, menuItem3, menuItem4]
        
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
