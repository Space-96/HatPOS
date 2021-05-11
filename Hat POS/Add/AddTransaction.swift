//
//  AddTransaction.swift
//  Hat POS
//
//  Created by Brendan on 5/7/21.
//
//Color Palette no. 273305

import UIKit

class AddTransactionViewController: UIViewController {
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var employeeIDText: UITextField!
    @IBOutlet var customerIDText: UITextField!
    @IBOutlet var productIDText: UITextField!
    @IBOutlet var statusMessage: UILabel!
    
    
    var employeeID : String?
    var customerID : String?
    var productID : String?
    
    var items = [AddArray]()
    
    override func viewDidLoad() {
        logo.layer.cornerRadius = 40
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        employeeID = employeeIDText.text
        customerID = customerIDText.text
        productID = productIDText.text
        employeeIDText.text = ""
        customerIDText.text = ""
        productIDText.text = ""
        
        
        let stringURL = "http://student07web.mssu.edu/serviceForTransactionAddition.php?employeeID=\(employeeID!)&customerID=\(customerID!)&productID=\(productID!)"
        
        if let url = URL(string: stringURL){
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                })
                task.resume()
            }
        statusMessage.text = "Transaction Added - Check Transaction Table"
    }
}
