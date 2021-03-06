//
//  CatTableViewController.swift
//  SmartPay
//
//  Created by Joachim Dittman on 27/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Home: UITableViewController, CLLocationManagerDelegate {
  var manager = CLLocationManager()
    var lat = 0.0
    var long = 0.0
    @IBOutlet weak var menu: UIBarButtonItem!
    
    
    func  calcDistance(latitude: Double, longitude: Double) -> Double{
        
        var unitLocation:CLLocation = CLLocation(latitude: lat, longitude:long)
        
        var storeLocation:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        
        var calcDistance = unitLocation.distanceFromLocation(storeLocation)
        return calcDistance;
    }
    func PartOfString(s: String, start: Int, length: Int) -> String
    {
        return s.substringFromIndex(advance(s.startIndex, start - 1)).substringToIndex(advance(s.startIndex, length))
    }

    
     func updateMap() {
        
        if (CLLocationManager.locationServicesEnabled())
        {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
        }
    }
    
    override func viewDidLoad() {
       demoSpinner()
        super.viewDidLoad()
        
        self.manager.requestWhenInUseAuthorization()
        //updateMap()
        
        var distanceString  = "\(calcDistance(55.676422, longitude:12.574691)/1000)"
        var km = ""
         km = "\(PartOfString(distanceString, start: 1, length: 3)) km"
        println(km)
        var profileData = "||||"
        defaults.setObject(profileData, forKey: "profileDataContainer")
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
    
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        
        println("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        long = locValue.longitude
          
        
        //stop updating location for manual update
        self.manager.stopUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(false)
       
        
     
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
 
        if(FBSession.activeSession().isOpen == false && login == false){
            
            var vc = self.storyboard?.instantiateViewControllerWithIdentifier("Login") as! Profile
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
        
        if self.revealViewController() != nil {
            menu.target = self.revealViewController()
            menu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // Uncomment to change the width of menu
            //self.revealViewController().rearViewRevealWidth = 62
        }
    }
    
    func demoSpinner() {
        
        
        
      
        if((calcDistance(55.676422, longitude:12.574691)/1000)>1){
            delay(seconds: 0.0, completion: {
                SwiftSpinner.show("Finder cafe", image: false)
            })
                delay(seconds: 3.5, completion: {
             SwiftSpinner.show("Intet fundet, henter cafe kortet... ", animated: true, image: false)
         })
              delay(seconds: 5.5, completion: {
                SwiftSpinner.hide()
            })
        }
        else{
            delay(seconds: 0.0, completion: {
                SwiftSpinner.show("Finder cafe", image: false)
            })
        delay(seconds: 2.0, completion: {
            SwiftSpinner.show("Cafe fundet... ", animated: true, image: false)
        })
        delay(seconds: 3.0, completion: {
            SwiftSpinner.show("", animated: false, image: true)
        })
       }
        
    }
    
    func delay(#seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
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
  
        
        // addSubView(indexPath.row,itemId: 1)
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
