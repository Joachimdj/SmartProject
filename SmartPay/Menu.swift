//
//  Menu.swift
//  SmartPay
//
//  Created by Joachim Dittman on 27/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
var itemId = 0;
class Menu: UITableViewController {
    var cellAmount = 0;
    var selectedCellIndexPath = [NSIndexPath]()
    
    let SelectedCellHeight: CGFloat = 88.0
    let UnselectedCellHeight: CGFloat = 44.0
    var container = [SQLRow]();
    @IBOutlet weak var Basket: UIBarButtonItem!
    override func viewDidLoad() {
              super.viewDidLoad()
        container = db.query("SELECT * FROM MenuItems WHERE cat = '\(Selectedcat)'")
        tableView.reloadData()
      
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList:", name:"refreshMyTableView", object: nil)
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
    func refreshList(notification: NSNotification){
       
        data = [SQLRow]()
        println(data.count)
        tableView.reloadData()
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
    

/*    func addSubView(row : Int, itemId:Double){
        let screenWidth = screenSize.width
        
        var myView = UIView()
        myView.frame = CGRectMake(0,44,screenWidth,40)
        myView.backgroundColor = UIColor.cyanColor()
        self.tableView.insertSubview(myView, belowSubview: self.tableView)
        
    }
    */
    
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("RESET_ AMOUNT\(cellAmount)")
        let cell: MenuItemCell = tableView.dequeueReusableCellWithIdentifier("MenuItem", forIndexPath: indexPath) as! MenuItemCell
        var row = container[indexPath.row]
        
        var name =  row["name"]!.asString()
        var id = row["id"]!.asInt()
        var desc = row["desc"]!.asString()
        var price = row["price"]!.asDouble()
        cell.titleLabel.text = "\(name)  \(id)"
        cell.subtitleLabel.text = desc       
        cell.amountLabel.text = "\(formatter.stringFromNumber(price)!)"
        cell.amount.text = "\(cellAmount)"
        cell.minus.enabled = false
        cell.add.tag = indexPath.row
        cell.minus.tag = indexPath.row
        println(cellAmount)
        if(cellAmount>0){  cell.minus.enabled = true}
        
        //Set cellAmount to zero
        cellAmount = 0
       return cell
        
        
    }

    @IBAction func add(sender: AnyObject) {
        
        //plus one to cellAmount
      
        var itemID = container[sender.tag]["id"]!.asInt()
        data = db.query("SELECT * FROM SelectedItems WHERE itemID=\(itemID)")
        if(data.count>0){
            
         var amount =   data[0]["amount"]!.asInt()
         var itemID =   data[0]["itemID"]!.asInt()
        cellAmount = amount;
        
        }
        println("\(itemID) \(cellAmount)")
      
       
        
        if(cellAmount==0){
            cellAmount++
            println("INSERT")
            let sqlDELETE = "DELETE FROM SelectedItems WHERE itemID=\(itemID)"
            db.execute(sqlDELETE)
        let sqlINSERT = "INSERT INTO SelectedItems VALUES(\(itemID), \(cellAmount) )"
        db.execute(sqlINSERT)
        }
        else
        {
             cellAmount++
            println("UPDATE")
            let sqlINSERT = "UPDATE SelectedItems SET amount=\(cellAmount) WHERE itemID=\(itemID)"
            db.execute(sqlINSERT)
        }
      
        
        //OPDATERE KURV
        CalculateBasket()
        Basket.title = "Kurv(\(formatter.stringFromNumber(basket)!))"
        
        //OPDATERE ROW
        var indexPath = NSIndexPath(forRow: sender.tag, inSection: 0 )
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
    }
 
    @IBAction func minus(sender: AnyObject) {
        //plus one to cellAmount
        
        var itemID = container[sender.tag]["id"]!.asInt()
        data = db.query("SELECT * FROM SelectedItems WHERE itemID=\(itemID)")
        if(data.count>0){
            
            var amount =   data[0]["amount"]!.asInt()
            var itemID =   data[0]["itemID"]!.asInt()
            cellAmount = amount;
            
        }
        println("\(itemID) \(cellAmount)")
        
         cellAmount--
     
            println("UPDATE")
            let sql = "UPDATE SelectedItems SET amount=\(cellAmount) WHERE itemID=\(itemID)"
            db.execute(sql)
       
        
        
        
        
        //OPDATERE KURV
        println(CalculateBasket())
        Basket.title = "Kurv(\(formatter.stringFromNumber(basket)!))"
        
        //OPDATERE ROW
        var indexPath = NSIndexPath(forRow: sender.tag, inSection: 0 )
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
    }
 
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
