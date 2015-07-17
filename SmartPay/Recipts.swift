//
//  Recipts.swift
//  SmartPay
//
//  Created by Joachim Dittman on 27/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit

class Recipts: UITableViewController {
 
    @IBOutlet weak var menuButton: UIBarButtonItem!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       dataRecipts = db.query("SELECT * FROM Recipts WHERE user ='1'")
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // Uncomment to change the width of menu
            //self.revealViewController().rearViewRevealWidth = 62
        }
        
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
       
        return dataRecipts.count
    }
 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Recipt", forIndexPath: indexPath) as! UITableViewCell
        
        var row = dataRecipts[indexPath.row]
         var storeID = row["storeId"]!.asInt()
        var Store = db.query("SELECT * FROM Stores WHERE id =\(storeID)")
        println(Store.count)
        if(Store.count>0){
            StoreName = Store[0]["name"]!.asString()
            cell.textLabel!.text = Store[0]["name"]?.asString()}
        var date = row["paymentDate"]!.asString()
        println(date)
     cell.detailTextLabel!.text = "\(date)"

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        SelectedRecipt = dataRecipts[indexPath.row]["id"]!.asInt()
        
        
          }
     override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
