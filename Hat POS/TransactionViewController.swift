//
//  TransactionViewController.swift
//  Hat POS
//
//  Created by Brendan on 4/8/21.
//

import UIKit

class TransactionViewController: UIViewController, TransactionModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var Logo2: UIImageView!
    
    
    var transactionModel = TransactionModel()
    var items = [Transactions]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logo2.layer.cornerRadius = 40
                
        tableView.delegate = self
        tableView.dataSource = self
        
        //Initiate calling the items download
        transactionModel.getItems()
        transactionModel.delegate = self
        
        let nib = UINib(nibName: "TransactionCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TranCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                
    }
    
    func transactionItemsDownloaded(transactionItems: [Transactions]) {
        
        self.items = transactionItems
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_  tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TranCell", for: indexPath) as! TransactionCell
        
        cell.tIDLabel.text = items[indexPath.row].transactionID
        cell.eIDLabel.text = items[indexPath.row].employeeID
        cell.cIDLabel.text = items[indexPath.row].customerID
        cell.pIDLabel.text = items[indexPath.row].productID
        cell.dateLabel.text = items[indexPath.row].date
        cell.subTotalLabel.text = items[indexPath.row].subTotal
        cell.taxLabel.text = items[indexPath.row].tax
        cell.totalLabel.text = items[indexPath.row].total
        
        return cell
    }
    
}
