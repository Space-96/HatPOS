//
//  DeleteTimeViewController.swift
//  Hat POS
//
//  Created by Austin Lindsey on 4/29/21.
//

import UIKit

class DeleteTimeViewController: UIViewController {

    @IBOutlet var logo: UIImageView!
    @IBOutlet var submissionIDText: UITextField!
    
    var submissionID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logo.layer.cornerRadius = 40
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        submissionID = submissionIDText.text
        
        let stringURL = "http://student07web.mssu.edu/serviceForTimeTrackingDeletion.php?submissionID="+submissionID!
        
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
