//
//  CatTableViewController.swift
//  SmartPay
//
//  Created by Joachim Dittman on 27/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit

class Cats: UITableViewController {

    @IBOutlet weak var Basket: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad() 
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
    
    }
    @IBAction func menuButtonTouched(sender: AnyObject) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return CatDic.count
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cats", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = CatDic[indexPath.row].name
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        Selectedcat = CatDic[indexPath.row].id  
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
