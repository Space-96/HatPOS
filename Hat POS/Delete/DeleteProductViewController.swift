//
//  DeleteProductViewController.swift
//  Hat POS
//
//  Created by Austin Lindsey on 4/29/21.
//

import UIKit

class DeleteProductViewController: UIViewController {

    @IBOutlet var logo: UIImageView!
    @IBOutlet var productIDText: UITextField!
    
    var productID : String?
    //var count = [Delete]()
    
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
//                    else {
//                        //self.parseJson(data!)
//                        print("Deleted")
//                    }
                })
                task.resume()
            }
    }
//
//    func parseJson(_ data:Data) {
//        do {
//            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
//            if jsonArray.isEmpty {
//                print("Empty Json")
//            }
//            for jsonResult in jsonArray {
//                let jsonDict = jsonResult as! [String:String]
//                let product = Delete(rowCount: jsonDict["COUNt(*)"]!)
//                print(product.rowCount)
//                count.append(product)
//            }
//
//        } catch  {
//            print("JSON Parse Error")
//        }
//    }
    
}
