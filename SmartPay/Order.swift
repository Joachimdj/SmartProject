//
//  Menu.swift
//  SmartPay
//
//  Created by Joachim Dittman on 27/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
class Order: UITableViewController {
    
     var data2 = [SQLRow]()
    let db = SQLiteDB.sharedInstance()
    var SelectedItems = [MenuItem]()
    override func viewDidLoad() {
        super.viewDidLoad()  
      
      data2 = db.query("SELECT name, itemID, price, sum(amount) as amount FROM SelectedItems LEFT JOIN MenuItems ON MenuItems.id=SelectedItems.ItemID GROUP BY MenuItems.id")
    tableView.reloadData()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
                                }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
      
      //  return OrderMenuItemDic.count
          return data2.count
    }
   
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderItems", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
      // cell.textLabel?.text = "\(OrderMenuItemDic[indexPath.row].name) x \(OrderMenuItemDic[indexPath.row].price).00 DKR"
       let row = data2[indexPath.row]
        if let task = row["name"] {
            
            var name =    task.asString()
           cell.textLabel?.text = name
        }
        if let  task2 = row["price"]{
            var task1 = row["amount"]
            var finalAmountPrItem = task2.asDouble() * task1!.asDouble()
 
            cell.detailTextLabel?.text = " \(formatter.stringFromNumber(finalAmountPrItem)!)"
                  }
 
        return cell
    }
    
    @IBAction func close(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
 
    
    }
    @IBAction func Tom(sender: AnyObject) {
        emtyBasket()
        tableView.reloadData()
         
         self.dismissViewControllerAnimated(true, completion: nil)
     
        
    }
 
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
