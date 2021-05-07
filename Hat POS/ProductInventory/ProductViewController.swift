//
//  ViewController.swift
//  Hat POS
//
//  Created by Brendan on 3/11/21.
//

import UIKit

class ProductViewController: UIViewController, HomeModelDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var MainMenuView: UIView!
    @IBOutlet weak var LogoutView: UIView!
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var TransactionButtonView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchContainer: UIView!
    
    var homeModel = HomeModel()
    var items = [Inventory]()
    var resultSearchController = UISearchController()
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
        
       /* resultSearchController = ({
            let controller = UISearchBar(searchResultsController: nil)
            controller.searchBar.frame = CGRect(x: 0, y: 0, width: 745, height: 44)
            controller.searchResultsUpdater = self
            controller.searchBar.becomeFirstResponder()
            controller.searchBar.delegate = self
            controller.searchBar.showsCancelButton = false
            controller.searchBar.autocapitalizationType = .words
            controller.searchBar.placeholder = "Type description of product you wish to lookup.."
            searchContainer.addSubview(controller.searchBar)
            return controller
        })()*/

        let nib = UINib(nibName: "InventoryCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "InvCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    //Functions to adjust size and cancel button
    func didPresentSearchController(_ searchController: UISearchController){
        resultSearchController.searchBar.frame = CGRect(x: 0, y: 0, width: 745, height: 44)
        resultSearchController.searchBar.showsCancelButton = true
        self.navigationController?.navigationBar.isTranslucent = true
    }
    func didDismissSearchController(_ searchController: UISearchController) {
        resultSearchController.searchBar.frame = CGRect(x: 0, y: 0, width: 745, height: 44.0)
        resultSearchController.searchBar.showsCancelButton = false
        
    }
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

