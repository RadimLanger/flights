//
//  itemsSetOutletsCell.swift
//  flights
//
//  Created by Radim Langer on 27/02/16.
//  Copyright © 2016 Radim Langer. All rights reserved.
//

import Foundation
import UIKit

class CellSettingOutlets: UITableViewCell {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var transfersNumber: UILabel!
    @IBOutlet weak var timeFromTo: UILabel!
    
    var newItem: cellDataModel? {
        didSet {
            if let item = newItem {
                fromLabel.text = "\(item.flyFrom) ⇾ \(item.flyTo)"
                priceLabel.text = "\(item.price) €"
                transfersNumber.text = "Transfers: \(item.routeCount)"
                timeFromTo.text = dateToDays(item.departureUTC, format: "EEE dd/MM") + " - " + dateToDays(item.departureUTC, format: "HH:mm") + " ⇾ " + dateToDays(item.arrivalUTC, format: "HH:mm")
            }
            else {
                return
            }
        }
    }
    
    func dateToDays(date: NSDate, format: String)->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.stringFromDate(date)
        
        return dateString
    }

    
}
