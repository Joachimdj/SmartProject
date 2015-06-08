//
//  databaseFunctions.swift
//  SmartPay
//
//  Created by Joachim Dittman on 08/06/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
import CoreData

class databaseFunctions: UIViewController {
  
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Print it to the console
        println(managedObjectContext)
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("SelectedItem", inManagedObjectContext: self.managedObjectContext!) as! SelectedItem
        
        newItem.itemID = 25
        newItem.amount = 23
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
