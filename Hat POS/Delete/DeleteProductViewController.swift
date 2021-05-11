//
//  DeleteProductViewController.swift
//  Hat POS
//
//  Created by Austin Lindsey on 4/29/21.
//
//Color Palette no. 273305

import UIKit

class DeleteProductViewController: UIViewController {

    @IBOutlet var logo: UIImageView!
    @IBOutlet var productIDText: UITextField!
    @IBOutlet var statusMessage: UILabel!
    
    var productID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logo.layer.cornerRadius = 40
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        productID = productIDText.text
        
        let stringURL = "http://student07web.mssu.edu/serviceForInventoryDeletion.php?productID="+productID!
        
        if let url = URL(string: stringURL){
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    else {
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
