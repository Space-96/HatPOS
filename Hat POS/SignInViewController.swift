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
    @IBOutlet var errorMessage: UILabel!
    
    var username: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logo.layer.cornerRadius = 40
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        username = usernameText.text
        password = passwordText.text
        
        let stringURL = "http://student07web.mssu.edu/serviceForLoginLookup.php?userName="+username!+"&passWord="+password!
        
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
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            if jsonArray.isEmpty {
                errorMessagePrint()
            }
            for jsonResult in jsonArray {
                let jsonDict = jsonResult as! [String:String]
                let login = SignIn(
                    username: jsonDict["userName"]!,
                    password: jsonDict["passWord"]!)
                signIn(login.username, login.password)
            }
            
        } catch  {
            print("JSON Parse Error")
        }
    }
    
    func signIn(_ jusername: String, _ jpassword: String) {
        if username == jusername && password == jpassword {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "goToHome", sender: self)
            }
        } else {
            errorMessagePrint()
        }
        
    }
    
    func errorMessagePrint() {
        DispatchQueue.main.async {
            self.errorMessage.text = "Invalid Login Information"
        }
    }
}
