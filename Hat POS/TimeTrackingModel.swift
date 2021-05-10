//
//  TimeTrackingModel.swift
//  Hat POS
//
//  Created by Levi Knight on 5/9/21.
//

import UIKit

let controler = TimeTracking()

protocol TimeTrackingDelegate {
    
    func timeItemsDownloaded(parsedItems: [TimeTrackingStruct])
    
}

class TimeTrackingModel: NSObject {
   
    var delegate:TimeTrackingDelegate?
    
    func timeGetItems() {
        
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
        var timeArray = [TimeTrackingStruct]()
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            if jsonArray.isEmpty {
                print("jsonArry returned Empty for some reason")
            }
            for jsonResult in jsonArray {
                let jsonDict = jsonResult as! [String:String]
                let submission = TimeTrackingStruct(submissionID: jsonDict["submissionID"]!, firstName: jsonDict["firstName"]!, lastName: jsonDict["lastName"]!, clocking: jsonDict["clocking"]!, dateAndTime: jsonDict["dateAndTime"]!)
                timeArray.append(submission)
            }
            
            delegate?.timeItemsDownloaded(parsedItems: timeArray)
            
        } catch  {
            print("JSON Parse Error for some reason")
        }
    }
}
