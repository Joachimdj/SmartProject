//
//  DLDemoMenuViewController.swift
//  DLHamburguerMenu
//
//  Created by Nacho on 5/3/15.
//  Copyright (c) 2015 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class DLDemoMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var profileImage: UIImageView!
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    // data
    let segues = ["Profile", "Kvitteringer","Betalingskort","Log ud"]
    let seguesName = [ "Profile", "Recipts","PaymentCard","Login"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        var myView = UIView()
      var facebookIDNow = ""
         let profileDataContainer = defaults.stringForKey("profileDataContainer")
        if (profileDataContainer != nil) {
        var profile = profileDataContainer!.componentsSeparatedByString("|");
        facebookIDNow = profile[4];
        println(FBSession.activeSession().isOpen)
        } 
 
        let url = NSURL(string: "https://graph.facebook.com/\(facebookIDNow)/picture?type=large")
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            
            // Display the image
            let image = UIImage(data: data)
            self.profileImage.image = image
            }
 
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate&DataSource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segues.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = segues[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(self.seguesName[indexPath.row] == "MenuCard"){
     self.dismissViewControllerAnimated(true, completion: nil)
        } else{
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier(self.seguesName[indexPath.row])
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    }
    
    // MARK: - Navigation
    
    func mainNavigationController() -> DLHamburguerNavigationController {
        return self.storyboard?.instantiateViewControllerWithIdentifier("DLDemoNavigationViewController") as! DLHamburguerNavigationController
    }
    
}
