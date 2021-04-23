//
//  SignInViewController.swift
//  Hat POS
//
//  Created by Austin Lindsey on 4/22/21.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logo.layer.cornerRadius = 40
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let username = usernameText.text
        let password = passwordText.text
        
        func handle(data: Data?, response: URLResponse?, error: Error?) {
            if error != nil {
                print(error!)
                return
            }
            if data != nil {
                // let valueString = String(data: value, encoding: .utf8)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
            }
        }
        
        let stringURL = "http://student07web.mssu.edu/serviceForLoginLookup.php?userName="+username!+"&passWord="+password!
        
        if let url = URL(string: stringURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            task.resume()
        }
    }
}
