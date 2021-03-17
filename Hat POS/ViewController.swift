//
//  ViewController.swift
//  Hat POS
//
//  Created by Brendan on 3/11/21.
//

import UIKit

class ViewController: UIViewController, HomeModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var homeModel = HomeModel()
    var items = [Inventory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set self as the tableview's data source and delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        //Initiate calling the items download
        homeModel.getItems()
        homeModel.delegate = self
        let nib = UINib(nibName: "InventoryCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "InvCell")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose o any resources that can be recreated.
    }
    
    func itemsDownloaded(inventoryItems: [Inventory]) {
        
        self.items = inventoryItems
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }

    // Mark: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvCell", for: indexPath) as! InventoryCell
        cell.idLabel.text = items[indexPath.row].productID
        cell.productNameLabel.text = items[indexPath.row].productName
        cell.qtyLabel.text = items[indexPath.row].quantity
        return cell
        
    }
}

