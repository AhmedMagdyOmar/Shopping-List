//
//  ItemsTableViewController.swift
//  Shopping List
//
//  Created by Ahmed on 3/5/21.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import UIKit
import JGProgressHUD

class ItemsTableViewController: UITableViewController {

    // MARK: vars
    var itemList: [Item] = []
    
    // MARK: Constant
    let hud = JGProgressHUD(style: .dark)

    
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    
    //MARK: IBAction
    @IBAction func addTobasket(_ sender: Any) {
        addToBasket()
    }
    
    
    @IBAction func addNewItem(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddItemViewController") as! AddItemViewController
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
    }

}


// MARK: - Helpers
extension ItemsTableViewController{
    
    // used to init screen for the first time
    func initView(){
        tableView.tableFooterView = UIView()
        loadItems()
    }
    
    // used to add product to basket
    func addToBasket(){
        
        for i in 0...itemList.count-1 {
            if  itemList[i].checked {
                saveItemsToBasket(itemList[i])
                itemList[i].checked = false
                
                self.hud.textLabel.text = "Added to basket!"
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 1.0)
                tableView.reloadData()
            }
        }
    }
}



// MARK: - Table view data source
extension ItemsTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath) as! ItemTableViewCell
        cell.generateCell(itemList[indexPath.row])
        cell.accessoryType = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}




// MARK: - Table view delegate
extension ItemsTableViewController{

    //MARK: Delete data
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = self.itemList[indexPath.row]
        deleteItemFromFirestore(item.id)
        self.itemList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }

      
    //MARK: checkmark rows
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemList[indexPath.row]
        item.checked = !item.checked
        tableView.cellForRow(at: indexPath)?.accessoryType = item.checked ? .checkmark : .none
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}



// MARK: - Delegation
extension ItemsTableViewController: AddItemDelegte {
    func addNewItem(item: Item) {
        itemList.append(item)
        self.tableView.reloadData()
    }
 }



// MARK: - Networking
extension ItemsTableViewController{
     
    // MARK: Load Our Data
     func loadItems() {
         ApiRequest.shared.requstData { (allItems) in

            self.itemList = allItems
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


