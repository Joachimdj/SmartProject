//
//  ViewController.swift
//  ScrollViewAutoLayoutExample
//
//  Created by Natasha Murashev on 6/10/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import UIKit

class NewOrder: UIViewController {
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
    let screenSize: CGRect = UIScreen.mainScreen().bounds
       var data2 = [SQLRow]()
    override func viewDidLoad() {
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "da_DK")
        super.viewDidLoad()
        createview() //calling the method
             }
    
    func createview(){
        data2 = db.query("SELECT name, itemID, price, sum(amount) as amount FROM SelectedItems LEFT JOIN MenuItems ON MenuItems.id=SelectedItems.ItemID GROUP BY MenuItems.id")
        // Do any additional setup after loading the view. 
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
         
        
        myscr = UIScrollView()
        myscr!.frame = CGRectMake(0,44.5,screenWidth,screenHeight)
       myscr!.backgroundColor = UIColor.cyanColor()
         myscr!.contentInset = UIEdgeInsetsZero;
        
        
        myscr!.scrollEnabled = true
        self.view.addSubview(myscr!)
        

        
        let image = UIImage(named: "basket.png")!
        imageView = UIImageView(image: image)
        imageView!.frame = CGRect(origin: CGPoint(x: 25, y: 0), size:image.size)
        myscr!.addSubview(imageView!)
        
        
        total = UILabel()
        total!.frame = CGRectMake(70,0,250,30)
        total!.font  = UIFont(name: total!.font.fontName, size: 10)
        total!.text = "Total"
        myscr!.addSubview(total!)
        
        totalAmount = UILabel()
        totalAmount!.frame = CGRectMake(70,15,250,30)
        totalAmount!.font  = UIFont(name: total!.font.fontName, size: 20)
        totalAmount!.text = "\(formatter.stringFromNumber(basket)!)"
        myscr!.addSubview(totalAmount!)
        
        amount = UILabel()
        amount!.frame = CGRectMake(70,15,250,30)
        amount!.font  = UIFont(name: amount!.font.fontName, size: 20)
        amount!.text = "\(formatter.stringFromNumber(basket)!)"
        myscr!.addSubview(amount!)
        
        
        addItems = UIButton()
        addItems!.frame = CGRectMake(screenWidth-70,40,60,45)
        addItems?.backgroundColor = UIColor.lightGrayColor()
        addItems!.setTitle("Ret", forState: UIControlState.Normal)
        addItems!.addTarget(self, action: "close:", forControlEvents: .TouchUpInside)
        myscr!.addSubview(addItems!)
         
        
        item = UILabel()
        item!.frame = CGRectMake(10,40,screenWidth-20,50)
        item!.font  = UIFont(name: total!.font.fontName, size: 32)
        item!.text = "Din bestilling"
        myscr!.addSubview(item!)
        
        var b : CGFloat = 100
         var c : CGFloat = 105
        for menuItem in data2  {
            
            amount = UILabel()
            amount!.frame = CGRectMake(5,b,screenWidth-10,0.2)
            amount!.backgroundColor = UIColor.grayColor()
            myscr!.addSubview(amount!)
            
          item = UILabel()
            item!.frame = CGRectMake(10,c,screenWidth-20,14)
            item!.font  = UIFont(name: total!.font.familyName, size: 12)
            var name = menuItem["name"]!.asString()
            var ItemAmount = menuItem["amount"]!.asString()
            item!.text = "\(name) x \(ItemAmount) stk. "
           myscr!.addSubview(item!)
         
            itemPrice = UILabel()
            itemPrice!.frame = CGRectMake(screenWidth-70,c,60,14)
            itemPrice!.font  = UIFont(name: total!.font.familyName, size: 12)
            var finalAmountPrItem = menuItem["amount"]!.asDouble() * menuItem["price"]!.asDouble()
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
        item!.text = "\(formatter.stringFromNumber(basket)!)"
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
        item!.text = "\(formatter.stringFromNumber(basket)!)"
        myscr!.addSubview(item!)
        
        
        b+=25
        c+=25
        
        addItems = UIButton()
        addItems!.frame = CGRectMake(10,b,screenWidth-20,60)
        addItems?.backgroundColor = UIColor.orangeColor()
        addItems!.setTitle("Til betaling", forState: UIControlState.Normal)
        addItems!.addTarget(self, action: "goToPayment:", forControlEvents: .TouchUpInside)
        myscr!.addSubview(addItems!)
        b+=125
        c+=25
        println(b)
        myscr!.contentSize = CGSizeMake(320,b)
        
    }
    
    func createPaymentWindow(){
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height
    myscr?.removeFromSuperview()
    myView = UIView()
    myView!.frame = CGRectMake(0,44.5,screenWidth,screenHeight)
    myView!.backgroundColor = UIColor.cyanColor()
        
    accountNumber = UITextField()
    accountNumber.frame = CGRectMake(10,20,screenWidth-20,50)
    accountNumber.backgroundColor = UIColor.whiteColor()
    accountNumber.font  = UIFont(name: total!.font.familyName, size: 25)
    accountNumber.keyboardType = UIKeyboardType.NumberPad
    accountNumber.placeholder = " Kort nummer"
        
     myView?.addSubview(accountNumber)

        
        accountNumber = UITextField()
        accountNumber.frame = CGRectMake(10,80,130,50)
        accountNumber.backgroundColor = UIColor.whiteColor()
        accountNumber.font  = UIFont(name: total!.font.familyName, size: 25)
        accountNumber.keyboardType = UIKeyboardType.NumberPad
        accountNumber.placeholder = " 12 / 11"
        
        myView?.addSubview(accountNumber)
        accountNumber = UITextField()
        accountNumber.frame = CGRectMake(150,80,50,50)
        accountNumber.backgroundColor = UIColor.whiteColor()
        accountNumber.font  = UIFont(name: total!.font.familyName, size: 25)
        accountNumber.keyboardType = UIKeyboardType.NumberPad
        accountNumber.placeholder = " xxx"
        
        myView?.addSubview(accountNumber)
        
        var switch1 = UISwitch()
        switch1.frame = CGRectMake(10,150,50,50)
        myView?.addSubview(switch1)
        
       var accountNumber1 = UILabel()
        accountNumber1.frame = CGRectMake(70,140,screenWidth-80,50)
        accountNumber1.font  = UIFont(name: total!.font.familyName, size: 12)
        accountNumber1.text = "Gem mit betalingskort"
        
        myView?.addSubview(accountNumber1)
        
        addItems = UIButton()
        addItems!.frame = CGRectMake(10,250,screenWidth-20,60)
        addItems?.backgroundColor = UIColor.orangeColor()
        addItems!.setTitle("Gennemfør", forState: UIControlState.Normal)
        addItems!.addTarget(self, action: "goToPayment:", forControlEvents: .TouchUpInside)
        myView!.addSubview(addItems!)
        
    self.view.addSubview(myView!)
    
        
        
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
        createPaymentWindow()
     
     // self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func Tom(sender: AnyObject) {
        emtyBasket() 
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
