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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.layer.cornerRadius = 40
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let stringURL = "http://student07web.mssu.edu/serviceForTimeTracking.php"
        
        if let url = URL(string: stringURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!, "for some reason")
                    return
                }
                else {
                    parseJson(data!)
                }
            })
            task.resume()
        }
    }

}

struct TimeTrackingValuse {
    var submissionID = "submissionID test"
    var firstName = ""
    var lastName = ""
    var clocking = ""
    var dateAndTime = ""
}

func parseJson(_ data:Data) {
    do {
        let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
        if jsonArray.isEmpty {
            print("jsonArry returned Empty for some reason")
        }
        for jsonResult in jsonArray {
            print(jsonResult)
        }
        
    } catch  {
        print("JSON Parse Error for some reason")
    }
}

//func itemsDownloaded(timeTrackingItems: [Inventory]) {
//    self.items = timeTrackingItems
//    DispatchQueue.main.async {
//        tableView.reloadData
//    }
//}

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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].submissionID
        
        return cell
    }
    
}

