//
//  ViewController.swift
//  flights
//
//  Created by Radim Langer on 26/02/16.
//  Copyright © 2016 Radim Langer. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBAction func sortBy(sender: AnyObject) {
        createActionSheet()
    }
    

    let parsing = parseJson()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parsing.parseFromFile("flights")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sortData(sortBy: String) {
        parsing.sortDataTableArray(sortBy)
    }
    
    
    // MARK: Action sheet
    
    func createActionSheet() {
        let optionMenu = UIAlertController(title: nil, message: "Sort by", preferredStyle: .ActionSheet)
    
        
        let DepartureTimeSort = UIAlertAction(title: "Departure time", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.sortData("DepartureUTCTime")
            self.tableView.reloadData()
        })
        let priceSort = UIAlertAction(title: "Price", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.sortData("Price")
            self.tableView.reloadData()
        })

        let transferSort = UIAlertAction(title: "Transfer", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.sortData("Transfer")
            self.tableView.reloadData()
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(DepartureTimeSort)
        optionMenu.addAction(priceSort)
        optionMenu.addAction(transferSort)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    
    // MARK: Setting tableView
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsing.dataTableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let item = parsing.dataTableArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CellSettingOutlets
        
        cell.newItem = item
        
        return cell
        
    }
    
    
    
    
}

