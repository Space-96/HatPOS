//
//  ViewController.swift
//  Hat POS
//
//  Created by Brendan on 3/11/21.
//

import UIKit

class ViewController: UIViewController, HomeModelDelegate {
    
    var homeModel = HomeModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeModel.getItems()
        homeModel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func itemsDownloaded(inventoryItems: [Inventory]) {
        
    }

}

