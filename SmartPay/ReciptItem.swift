//
//  ViewController.swift
//  ScrollViewAutoLayoutExample
//
//  Created by Natasha Murashev on 6/10/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import UIKit

class ReciptItem: UIViewController {
    var myscr : UIScrollView?
    var myView : UIView?
    var total : UILabel?
    var amount : UILabel?
    var item : UILabel?
    var itemPrice : UILabel?
    var mylbl : UILabel?
    var addItems : UIButton?
    var totalAmount : UILabel?
    var imageView : UIImageView?
    var accountNumber: UITextField!
    var TotalBasketAmount = 0.0
    
    override func viewDidLoad() {
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
        super.viewDidLoad()
        createview() //calling the method
    }
    
    func createview(){
        data2 = db.query("SELECT * FROM Recipts WHERE id=\(SelectedRecipt)")
        // Do any additional setup after loading the view.
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        myscr = UIScrollView()
        myscr!.frame = CGRectMake(0,0,screenWidth,screenHeight)
        myscr!.backgroundColor = UIColor.cyanColor()
        myscr!.contentInset = UIEdgeInsetsZero;
        
        
        myscr!.scrollEnabled = true
        self.view.addSubview(myscr!)
        
        total = UILabel()
        total!.frame = CGRectMake(screenWidth-105,0,105,30)
        total!.font  = UIFont(name: total!.font.fontName, size: 12)
        total!.text = data2[0]["paymentDate"]?.asString()
        myscr!.addSubview(total!)
        total = UILabel()
        total!.frame = CGRectMake(10,0,screenWidth-10,30)
        total!.font  = UIFont(name: total!.font.fontName, size: 25)
        total!.text = StoreName
        myscr!.addSubview(total!)
        
        total = UILabel()
        total!.frame = CGRectMake(screenWidth-105,0,105,30)
        total!.font  = UIFont(name: total!.font.fontName, size: 12)
        total!.text = data2[0]["paymentDate"]?.asString()
        myscr!.addSubview(total!)
        total = UILabel()
        total!.frame = CGRectMake(10,25,screenWidth-10,30)
        total!.font  = UIFont(name: total!.font.fontName, size: 12)
        total!.text = "Ordre ID: 23"
        myscr!.addSubview(total!)
        
        
        addItems = UIButton()
        addItems!.frame = CGRectMake(screenWidth-120,40,110,45)
        addItems?.backgroundColor = UIColor.lightGrayColor()
        addItems!.setTitle("send pr mail", forState: UIControlState.Normal)
        addItems!.addTarget(self, action: "sendPrMail:", forControlEvents: .TouchUpInside)
        myscr!.addSubview(addItems!)
        
        
        item = UILabel()
        item!.frame = CGRectMake(10,40,screenWidth-20,50)
        item!.font  = UIFont(name: total!.font.fontName, size: 32)
        item!.text = "Dit køb"
        myscr!.addSubview(item!)
        
        var b : CGFloat = 100
        var c : CGFloat = 105
        var string: String = data2[0]["menuItems"]!.asString()
        var array = string.componentsSeparatedByString("|");
        
        for arr in array  {
          
            var string: String = arr
            var newArray = string.componentsSeparatedByString(",");
            var MenuItems = db.query("SELECT * FROM MenuItems WHERE id=\(newArray[0])")
          
            amount = UILabel()
            amount!.frame = CGRectMake(5,b,screenWidth-10,0.2)
            amount!.backgroundColor = UIColor.grayColor()
            myscr!.addSubview(amount!)
            
            item = UILabel()
            item!.frame = CGRectMake(10,c,screenWidth-20,14)
            item!.font  = UIFont(name: total!.font.familyName, size: 12)
            var name = MenuItems[0]["name"]!.asString()
             var price = MenuItems[0]["price"]!.asDouble()
            item!.text = "\(name) x \(newArray[1]) stk. "
            myscr!.addSubview(item!)
            
            itemPrice = UILabel()
            itemPrice!.frame = CGRectMake(screenWidth-70,c,60,14)
            itemPrice!.font  = UIFont(name: total!.font.familyName, size: 12)
            var finalAmountPrItem = (newArray[1] as NSString).doubleValue * price
            TotalBasketAmount  += finalAmountPrItem
            itemPrice!.text = "\(formatter.stringFromNumber(finalAmountPrItem)!)"
            myscr!.addSubview(itemPrice!)
          
            b+=25
            c+=25
        }
        amount = UILabel()
        amount!.frame = CGRectMake(5,b,screenWidth-10,0.5)
        amount!.backgroundColor = UIColor.grayColor()
        myscr!.addSubview(amount!)
        
        
        item = UILabel()
        item!.frame = CGRectMake(10,c,screenWidth-20,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "Subtotal"
        myscr!.addSubview(item!)
        
        item = UILabel()
        item!.frame = CGRectMake(screenWidth-70,c,60,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "\(formatter.stringFromNumber(TotalBasketAmount)!)"
        myscr!.addSubview(item!)
        
        b+=25
        c+=25
        
        amount = UILabel()
        amount!.frame = CGRectMake(5,b,screenWidth-10,1)
        amount!.backgroundColor = UIColor.grayColor()
        myscr!.addSubview(amount!)
        
        item = UILabel()
        item!.frame = CGRectMake(10,c,screenWidth-20,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "Total"
        myscr!.addSubview(item!)
        
        item = UILabel()
        item!.frame = CGRectMake(screenWidth-70,c,60,14)
        item!.font  = UIFont(name: total!.font.familyName, size: 12)
        item!.text = "\(formatter.stringFromNumber(TotalBasketAmount)!)"
        myscr!.addSubview(item!)
        
        
        b+=25
        c+=25
         
        b+=125
        c+=25
        println(b)
        myscr!.contentSize = CGSizeMake(320,b)
        
    }
    
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func goToPayment(sender: AnyObject) {
        myscr?.removeFromSuperview() 
        // self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func em(sender: AnyObject) {
        println("EM")
        emtyBasket()
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func Tom(sender: AnyObject) {
        emtyBasket()
        println("TOM")
        
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
