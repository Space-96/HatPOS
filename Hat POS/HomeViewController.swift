//
//  HomeViewController.swift
//  Hat POS
//
//  Created by Austin Lindsey on 4/22/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logo.layer.cornerRadius = 40
    }
    

    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "logout", sender: self)
    }

}
