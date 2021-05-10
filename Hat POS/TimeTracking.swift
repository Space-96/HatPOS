//
//  TimeTracking.swift
//  Hat POS
//
//  Created by Levi Knight on 5/6/21.
//

import UIKit

class TimeTracking: UIViewController{
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var tableView: UITableView!
    

    var items = [TimeTrackingValuse]()

    struct TimeTrackingValuse {
        var submissionID = "submissionID test"
        var firstName = ""
        var lastName = ""
        var clocking = ""
        var dateAndTime = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.layer.cornerRadius = 40
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TimeTrackingCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TimeTrackingIDFlyerLabel")
        
        let stringURL = "http://student07web.mssu.edu/serviceForTimeTracking.php"
        
        if let url = URL(string: stringURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!, "for some reason")
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
        var timeArray = [TimeTrackingValuse]()
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            if jsonArray.isEmpty {
                print("jsonArry returned Empty for some reason")
            }
            for jsonResult in jsonArray {
                let jsonDict = jsonResult as! [String:String]
                let submission = TimeTrackingValuse(submissionID: jsonDict["submissionID"]!, firstName: jsonDict["firstName"]!, lastName: jsonDict["lastName"]!, clocking: jsonDict["clocking"]!, dateAndTime: jsonDict["dateAndTime"]!)
                timeArray.append(submission)
                //print(jsonResult)
            }
            itemsDownloaded(timeTrackingItems: timeArray)
            
        } catch  {
            print("JSON Parse Error for some reason")
        }
    }

    func itemsDownloaded(timeTrackingItems: [TimeTrackingValuse]) {
        print(timeTrackingItems)
        items = timeTrackingItems
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension TimeTracking: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
    }
}

extension TimeTracking: UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTrackingIDFlyerLabel", for: indexPath) as! TimeTrackingCell
        
        //cell.textLabel?.text = items[indexPath.row].submissionID
        //cell.idLabel.text = items[indexPath.row].firstName
        //cell.productNameLabel.text = items[indexPath.row].lastName
        cell.NO1.text = items[indexPath.row].submissionID
        cell.NO2.text = items[indexPath.row].firstName
        cell.NO3.text = items[indexPath.row].lastName
        cell.NO4.text = items[indexPath.row].clocking
        cell.NO5.text = items[indexPath.row].dateAndTime
        
        return cell
    }
}
