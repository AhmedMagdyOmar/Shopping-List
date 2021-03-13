//
//  BasketViewController.swift
//  Shopping List
//
//  Created by Ahmed on 3/11/21.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import UIKit

class BasketTableViewController: UITableViewController {

    // Mark:  Vars
    var basketList: [Item] = []
    
    // MARK:  View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initView()
      }
}



// MARK: - Helpers
extension BasketTableViewController {
    
   // used to init screen for the first time
    func initView(){
        tableView.tableFooterView = UIView()
        loadBasketItems()
        tableView.reloadData()

    }
}


// MARK: - Table view data source
extension BasketTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell", for: indexPath) as! ItemTableViewCell
        cell.generateCell(basketList[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}


// MARK: - Table view delegate
extension BasketTableViewController {
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = self.basketList[indexPath.row]
        deleteItemFromBasket(item.id)
        self.basketList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
}

// MARK: - Networking
extension BasketTableViewController {
    
    // MARK: Load Our Data
    func loadBasketItems() {
        downloadBasketItems { (basketItems) in
            self.basketList = basketItems
            self.tableView.reloadData()
        }
    }
}


    




