//
//  parseJson.swift
//  flights
//
//  Created by Radim Langer on 26/02/16.
//  Copyright © 2016 Radim Langer. All rights reserved.
//

import UIKit
import Foundation


class parseJson {
    
    var dataTableArray = [cellDataModel]()

    

    func sortDataTableArray(sortBy: String) {
        switch (sortBy) {
            case "Price":
                dataTableArray.sortInPlace() { $0.price < $1.price }
            break
            
            case "DepartureUTCTime":
                dataTableArray.sortInPlace() { $0.departureUTC.timeIntervalSince1970 < $1.departureUTC.timeIntervalSince1970 }
            break
            
            case "Transfer":
                dataTableArray.sortInPlace() { $0.routeCount < $1.routeCount }
            break
            
        default: break
        }

    }
    
    
    func downloadDataFromURL(urlString: String) {
        let url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            dispatch_sync(dispatch_get_main_queue(), {
            // DO SOMETHING
            } )
        }
        task.resume()
    }

    
    func parseFromFile(parseFileName: String) {
        
        if let path = NSBundle.mainBundle().pathForResource(parseFileName, ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    if let dataArray = jsonResult["data"] as? Array<AnyObject> {

                        for data in dataArray {
                            
                            let cityFrom = data["cityFrom"] as! String
                            let cityTo = data["cityTo"] as! String
                            
                            let price = data["price"] as! Int
                            
                            let aTimeUTCStamp = data["aTimeUTC"] as! NSTimeInterval
                            let dTimeUTCStamp = data["dTimeUTC"] as! NSTimeInterval
                            let aTimeUTC = NSDate(timeIntervalSince1970: aTimeUTCStamp)
                            let dTimeUTC = NSDate(timeIntervalSince1970: dTimeUTCStamp)
                            
                            let flightDuration = NSDate(timeIntervalSince1970: aTimeUTCStamp - dTimeUTCStamp)
                            
                            let route = data["route"] as! NSArray
                            let numberRoutes = route.count

                            dataTableArray.append(cellDataModel(
                                flyFrom: cityFrom,
                                flyTo: cityTo,
                                price: price,
                                routeCount: numberRoutes,
                                arrivalUTC: aTimeUTC,
                                departureUTC: dTimeUTC,
                                duration: flightDuration
                            ))
                        }
                    }
                } catch {
                    print("JSON error, parsing error")
                }
            } catch {
                print("JSON error, file is missing")
            }
        }
    }
    
}