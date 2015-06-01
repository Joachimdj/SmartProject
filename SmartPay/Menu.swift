//
//  Menu.swift
//  SmartPay
//
//  Created by Joachim Dittman on 27/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
class Menu: UITableViewController {
    
    var container = [SQLRow]();
    @IBOutlet weak var Basket: UIBarButtonItem!
    override func viewDidLoad() {
              super.viewDidLoad()
        var data2 = db.query("SELECT * FROM MenuItems WHERE cat = '\(Selectedcat)'")
        container = data2
        tableView.reloadData() 
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
        
    }
    override func viewWillAppear(animated: Bool) {
         super.viewWillAppear(false)
     Basket.title = "Kurv(\(formatter.stringFromNumber(basket)!))"
        var shadow = NSShadow()
        shadow.shadowColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        shadow.shadowOffset = CGSizeMake(0, 1)
        var color : UIColor = UIColor(red: 220.0/255.0, green: 104.0/255.0, blue: 1.0/255.0, alpha: 1.0)
        var color1 : UIColor = UIColor(red: 220.0/255.0, green: 104.0/255.0, blue: 1.0/255.0, alpha: 0.1)
        var titleFont : UIFont = UIFont(name: "AmericanTypewriter", size: 12.0)!
        
        var attributes = [
            NSForegroundColorAttributeName : color,
            NSShadowAttributeName : shadow,
            NSFontAttributeName : titleFont,
            NSBackgroundColorAttributeName : color1
        ]
        
        Basket.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
 
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
       return container.count
    
    }
    

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MenuItemCell = tableView.dequeueReusableCellWithIdentifier("MenuItem", forIndexPath: indexPath) as! MenuItemCell
        var row = container[indexPath.row]
        
        var name = row["name"]!.asString()
         var desc = row["desc"]!.asString()
        var price = row["price"]!.asDouble()
        cell.titleLabel.text = name
        cell.subtitleLabel.text = desc
      //  cell.textLabel?.text = name
      
        cell.amountLabel.text = "\(formatter.stringFromNumber(price)!)"
       
        return cell
    }


    @IBAction func menu(sender: AnyObject) {
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   
         var row = container[indexPath.row]
         var itemId = row["id"]!.asInt()
        
        let sql = "INSERT INTO SelectedItems(id, itemID, amount ) VALUES (1, \(itemId), 1)"
          db.execute(sql) 
        CalculateBasket()
         Basket.title = "Kurv(\(formatter.stringFromNumber(basket)!))"
        
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
