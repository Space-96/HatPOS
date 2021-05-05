//
//  Transactions.swift
//  Hat POS
//
//  Created by Brendan on 4/8/21.
//

import Foundation

struct Transactions {
    
    var transactionID = ""
    var employeeID = ""
    var customerID = ""
    var productID = ""
    var date = ""
    var subTotal = ""
    var tax = ""
    var total = ""
    
}

var transactionItems : [Transactions] = []
var filteredTransactions : [Transactions] = []
