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
    let segues = ["Menu kort", "Profile", "Kvitteringer","Betalingskort","Log ud"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        var myView = UIView() 
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
        
        let nvc = self.mainNavigationController()
        if let hamburguerViewController = self.findHamburguerViewController() {
            hamburguerViewController.hideMenuViewControllerWithCompletion({ () -> Void in
                nvc.visibleViewController.performSegueWithIdentifier(self.segues[indexPath.row], sender: nil)
                hamburguerViewController.contentViewController = nvc
            })
        }
    }
    
    // MARK: - Navigation
    
    func mainNavigationController() -> DLHamburguerNavigationController {
        return self.storyboard?.instantiateViewControllerWithIdentifier("DLDemoNavigationViewController") as! DLHamburguerNavigationController
    }
    
}
