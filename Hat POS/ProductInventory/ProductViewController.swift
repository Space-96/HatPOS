//
//  ViewController.swift
//  Hat POS
//
//  Created by Brendan on 3/11/21.
//

import UIKit

class ProductViewController: UIViewController, HomeModelDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var homeModel = HomeModel()
    var items = [Inventory]()
    var lookupItems = [Inventory]()
    var searchActive : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logo.layer.cornerRadius = 40
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Initiate calling the items download
        homeModel.getItems()
        homeModel.delegate = self
        
        searchBar.delegate = self

        let nib = UINib(nibName: "InventoryCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "InvCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    //Functions to adjust size and cancel button
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose o any resources that can be recreated.
    }
    
    func itemsDownloaded(inventoryItems: [Inventory]) {
        
        self.items = inventoryItems
        self.lookupItems = inventoryItems
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }

    // Mark: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return lookupItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvCell", for: indexPath) as! InventoryCell
        
            cell.idLabel.text = lookupItems[indexPath.row].productID
            cell.productNameLabel.text = lookupItems[indexPath.row].productName
            cell.qtyLabel?.text = lookupItems[indexPath.row].quantity
            cell.purchasePriceLabel.text = lookupItems[indexPath.row].unitPurchasePrice
            return cell
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        if let searchTerm = searchBar.text, !searchTerm.isEmpty {
            lookupItems = items.filter { result in return result.productDescription.contains(searchTerm) ||
            result.productID.contains(searchTerm) ||
            result.productName.contains(searchTerm)
        }
        }
        else
        {
            lookupItems = items
            
        }
        
        self.tableView.reloadData()
    }
}

