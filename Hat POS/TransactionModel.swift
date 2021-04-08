//
//  TransactionModel.swift
//  Hat POS
//
//  Created by Brendan on 4/8/21.
//

import UIKit

protocol TransactionModelDelegate {
    
    func transactionItemsDownloaded(transactionItems: [Transactions])
    
}

class TransactionModel: NSObject {
    
    var delegate:TransactionModelDelegate?

    func getItems() {
        // Hit web service url
        let serviceUrl = "http://student07.mssu.edu/serviceForTransactions.php"
        
        // Download the json data
        let url = URL(string: serviceUrl)
        
        if let url = url {
            
            // Create URL session
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler:
                { (data, response, error) in
                
                if error == nil {
                    // Succeeded
                    
                    // Call the parse Json function on the data
                    self.parseJson(data!)
                }
                else{
                    // Error
                }
            })
            
            // Start task
            task.resume()
        }
        //notify the view controller and pass the data back
    }
    
    func parseJson(_ data:Data){
        
        var transactionArray = [Transactions]()
        
        do {
            //Parse the data into location structs
        let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            // Loop through each result in the json array
            for jsonResult in jsonArray {
                
                // Cast json result as a dictionary
                let jsonDict = jsonResult as! [String:String]
                
                // Create new Transaction and set its properties
                let tran = Transactions(transactionID: jsonDict["transactionID"]!, customerID: jsonDict["customerID"]!, productID: jsonDict["productID"]!, date: jsonDict["date"]!, time: jsonDict["time"]!, paymentType: jsonDict["paymentType"]!, subTotal: jsonDict["subTotal"]!, tax: jsonDict["tax"]!, total: jsonDict["total"]!)
                transactionArray.append(tran)
            }
            
            delegate?.transactionItemsDownloaded(transactionItems: transactionArray)
        }
        catch{
            print("There was an error I guess")
        }
    
    }
    
}
