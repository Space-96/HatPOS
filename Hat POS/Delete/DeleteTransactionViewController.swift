//
//  DeleteTransactionViewController.swift
//  Hat POS
//
//  Created by Austin Lindsey on 4/29/21.
//

import UIKit

class DeleteTransactionViewController: UIViewController {

    @IBOutlet var logo: UIImageView!
    @IBOutlet var transactionIDText: UITextField!
    
    var transactionID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logo.layer.cornerRadius = 40
    }

    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        transactionID = transactionIDText.text
        
        let stringURL = "http://student07web.mssu.edu/serviceForTransactionDeletion.php?transactionID="+transactionID!
        
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

    }
}
