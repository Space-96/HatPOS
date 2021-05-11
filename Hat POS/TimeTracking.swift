//
//  TimeTracking.swift
//  Hat POS
//
//  Created by Levi Knight on 5/6/21.
//
//Color Palette no. 273305

import UIKit

class TimeTracking: UIViewController, UITableViewDataSource, UITableViewDelegate, TimeTrackingDelegate {
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var tableView: UITableView!
    

    var items = [TimeTrackingStruct]()
    var homeModel = TimeTrackingModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.layer.cornerRadius = 40
        
        tableView.delegate = self
        tableView.dataSource = self
        
        homeModel.timeGetItems()
        homeModel.delegate = self
        
        let nib = UINib(nibName: "TimeTrackingCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TimeTrackingIDFlyerLabel")
    
    }

    func timeItemsDownloaded (parsedItems: [TimeTrackingStruct]) {
        self.items = parsedItems
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped me!")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "SubmissionID  Firstname               Lastname                                            clocking    dateAndTime"
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTrackingIDFlyerLabel", for: indexPath) as! TimeTrackingCell
            
        cell.NO1.text = items[indexPath.row].submissionID
        cell.NO2.text = items[indexPath.row].firstName
        cell.NO3.text = items[indexPath.row].lastName
        cell.NO4.text = items[indexPath.row].clocking
        cell.NO5.text = items[indexPath.row].dateAndTime
            
        return cell
    }
    

}


