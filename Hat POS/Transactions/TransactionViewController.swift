//
//  TransactionViewController.swift
//  Hat POS
//
//  Created by Brendan on 4/8/21.
//

import UIKit

class TransactionViewController: UIViewController, TransactionModelDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Logo2: UIImageView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var transactionModel = TransactionModel()
    var items = [Transactions]()
    var filteredTransactions = [Transactions]()
    var searchActive : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logo2.layer.cornerRadius = 40
                
        tableView.delegate = self
        tableView.dataSource = self
        
        //Initiate calling the items download
        transactionModel.getItems()
        transactionModel.delegate = self
        searchBar.delegate = self


        
        let nib = UINib(nibName: "TransactionCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TranCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                
    }
    
    func transactionItemsDownloaded(transactionItems: [Transactions]) {
        
        self.items = transactionItems
        self.filteredTransactions = transactionItems
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTransactions.count
    }
    func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TranCell", for: indexPath) as! TransactionCell
        
        cell.tIDLabel.text = filteredTransactions[indexPath.row].transactionID
        cell.eIDLabel.text = filteredTransactions[indexPath.row].employeeID
        cell.cIDLabel.text = filteredTransactions[indexPath.row].customerID
        cell.pIDLabel.text = filteredTransactions[indexPath.row].productID
        cell.dateLabel.text = filteredTransactions[indexPath.row].date
        cell.subTotalLabel.text = filteredTransactions[indexPath.row].subTotal
        cell.taxLabel.text = filteredTransactions[indexPath.row].tax
        cell.totalLabel.text = filteredTransactions[indexPath.row].total
        
        return cell
    }
    //MARK: - Search Bar
    
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           
        if let searchTerm = searchBar.text, !searchTerm.isEmpty {
            filteredTransactions = items.filter { result in return result.transactionID.contains(searchTerm) ||
               result.customerID.contains(searchTerm) ||
               result.employeeID.contains(searchTerm) ||
               result.productID.contains(searchTerm)
        }
        }
        else
        {
            filteredTransactions = items
               
        }
           
        self.tableView.reloadData()
       }

    
}
