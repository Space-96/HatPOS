//
//  TransactionViewController.swift
//  Hat POS
//
//  Created by Brendan on 4/8/21.
//

import UIKit

class TransactionViewController: UIViewController, TransactionModelDelegate {

    var transactionModel = TransactionModel()
    var items = [Transactions]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        //Initiate calling the items download
        transactionModel.getItems()
        transactionModel.delegate = self

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose o any resources that can be recreated.
    }
    
    func transactionItemsDownloaded(transactionItems: [Transactions]) {
        
        self.items = transactionItems
        
        DispatchQueue.main.async{
            
        }
        print(items)
    }
    
}
