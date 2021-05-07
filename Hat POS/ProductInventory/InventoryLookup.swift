//
//  InventoryLookup.swift
//  Hat POS
//
//  Created by Brendan on 5/6/21.
//

import UIKit

protocol InventoryLookupDelegate {
    
    func inventoryItemsDownloaded(inventoryLookupItems: [Inventory])
    
}

class InventoryLookup: NSObject {
    
    var delegate:InventoryLookupDelegate?
    static let sharedInstance = InventoryLookup()
    var lookupText: String = ""

    func getItems() {
        // Hit web service url
        let serviceUrl = "http://student07web.mssu.edu/serviceForInventoryLookup.php?productDescription="+lookupText
        print(lookupText)
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
                    print(error!)
                    return
                    // Error
                }
            })
            // Start task
            task.resume()
        }
    }
    //notify the view controller and pass the data back
    func parseJson(_ data:Data){
        
        var invArray = [Inventory]()
        
        do {
            //Parse the data into location structs
        let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            if jsonArray.isEmpty {
                print("Empty JsonArray")
            }
            // Loop through each result in the json array
            for jsonResult in jsonArray {
                // Cast json result as a dictionary
                let jsonDict = jsonResult as! [String:String]
                
                // Create new Inventory and set its properties
                let inv = Inventory(productID: jsonDict["productID"]!, productName: jsonDict["productName"]!, productDescription: jsonDict["productDescription"]!, unitPurchasePrice: jsonDict["unitPurchasePrice"]!, unitSalePrice: jsonDict["unitSalePrice"]!, quantity: jsonDict["quantity"]!, isActive: jsonDict["isActive"]!)
                invArray.append(inv)
            }
            
            delegate?.inventoryItemsDownloaded(inventoryLookupItems: invArray)
        }
        catch{
            print("There was an error I guess")
        }
    
    }
    
}
