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
    @IBOutlet var statusMessage: UILabel!
    
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
                    }else {
                        self.parseJson(data!)
                    }
                })
                task.resume()
            }
    }
    
    func parseJson(_ data:Data) {
        var jsonDict = [String:String]()
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            if jsonArray.isEmpty {
                print("Empty Json")
            }
            for jsonResult in jsonArray {
                jsonDict.merge(jsonResult as! [String:String]) { (current, _) in current }
            }
            let product = Delete(preCount: jsonDict["preCount"]!, postCount: jsonDict["postCount"]!)
            validateDelete(product.preCount, product.postCount)
        } catch  {
            print("JSON Parse Error")
        }
    }
    
    func validateDelete(_ before: String, _ after: String) {
        if Int(before) == Int(after) {
            DispatchQueue.main.async {
                self.statusMessage.text = "Delete Failed"
            }
        } else {
            DispatchQueue.main.async {
                self.statusMessage.text = "Delete Successful"
            }
        }
    }
}
