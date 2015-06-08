//
//  DataManager.swift
//  SmartPay
//
//  Created by Joachim Dittman on 27/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit 

// PUBLIC DATA DICTONARYS
var CatDic = [Cat]()
var MenuItemDic = [MenuItem]()   
var UserDic = [User]()
var paymentCardDic = [PaymentCard]()
var data2 = [SQLRow]()
var dataRecipts = [SQLRow]()
var data = [SQLRow]()

//PUBLIC DATA VALUES
var Selectedcat = 0
var basket = 0.0
var SelectedRecipt = 0
var StoreName = ""

//USER DATA 
var login = true


//PUBLIC INSTANCES
var formatter = NSNumberFormatter()
let db = SQLiteDB.sharedInstance()
let defaults = NSUserDefaults.standardUserDefaults()


     let screenSize: CGRect = UIScreen.mainScreen().bounds

   func loadCatData(){
    let sqlDelete = "DROP TABLE MenuItems"
    db.execute(sqlDelete)
    let sqlDelete1 = "DROP TABLE  SelectedItems"
    db.execute(sqlDelete1)
    let sqlDelete2 = "DROP TABLE  Categories"
    db.execute(sqlDelete2)
    let sqlDelete6 = "DROP TABLE  Recipts"
    db.execute(sqlDelete6)
    let sqlDelete7 = "DROP TABLE  Stores"
    db.execute(sqlDelete7)
    
    
    let sql4 = "CREATE TABLE Categories(id INTEGER PRIMARY KEY ASC, name, storeId INTEGER)"
    db.execute(sql4)
    
    let sql = "CREATE TABLE MenuItems(id INTEGER PRIMARY KEY ASC, name, desc, price NUMBER, currentAmount NUMBER, cat INTEGER , storeId INTEGER)"
    db.execute(sql)
    
    let sql5 = "CREATE TABLE Recipts(id INTEGER PRIMARY KEY ASC, user, menuItems, paymentAmount NUMBER, paymentDate, storeId INTEGER)"
    db.execute(sql5)
    
    let sql2 = "CREATE TABLE SelectedItems(itemID, amount)"
    db.execute(sql2)
    
    let sql6 = "CREATE TABLE Stores(id, name)"
    db.execute(sql6)
 
    let sql12 = "INSERT INTO Stores(id, name) VALUES (1,'Bastard cafe')"
     db.execute(sql12)
   
    
    
    CatDic.append(Cat(id:1,name:"Vand",storeId:1))
    CatDic.append(Cat(id:2,name:"Mad",storeId:1))
    CatDic.append(Cat(id:3,name:"Snaks",storeId:1))
    CatDic.append(Cat(id:4,name:"Alkohol",storeId:1))
    CatDic.append(Cat(id:5,name:"Varme drikke",storeId:1))
    CatDic.append(Cat(id:6,name:"Øvrige",storeId:1))
    
    for cat in CatDic{
        let sql = "INSERT INTO categories(id, name, storeId) VALUES (\(cat.id),'\(cat.name)', \(cat.storeId))"
        let rc = db.execute(sql)
    }
    
}

   func loadMenuItemData(){
  
    var i = 0
    
    for(var b = 0; b<10;  b++){
     
    MenuItemDic.append(MenuItem(id:i,name:"Øl (Tuborg)", desc : "Something about", price: 20, currentAmount: 200, cat: 1, storeId:1 ))
        i++
    
    MenuItemDic.append(MenuItem(id:i,name:"Toast", desc : "Something about", price: 20, currentAmount: 100, cat: 2, storeId:1 ))
         i++
        
    MenuItemDic.append(MenuItem(id:i,name:"Fritter", desc : "Something about", price: 30, currentAmount: 100, cat: 3, storeId:1 ))
         i++
    MenuItemDic.append(MenuItem(id:i,name:"Popkorn", desc : "Something about", price: 15, currentAmount: 400, cat: 4, storeId:1 ))
        i++
    MenuItemDic.append(MenuItem(id:i,name:"Kage", desc : "Something about", price: 10, currentAmount: 400, cat: 4, storeId:1 ))
        i++
   
    }
    for menuItem in MenuItemDic{
        let sql = "INSERT INTO MenuItems(id, name, desc, price, currentAmount, cat, storeId) VALUES (\(menuItem.id),'\(menuItem.name)','\(menuItem.desc)', '\(menuItem.price)', '\(menuItem.currentAmount)','\(menuItem.cat)', \(menuItem.storeId))"
        let rc = db.execute(sql)
    }
    
    
     }


func loadReciptsData(){
    println("Load recipts")

  
    for(var b = 0; b<10;  b++){
        let sql = "INSERT INTO Recipts(id, user, menuItems, paymentAmount, paymentDate, storeId) VALUES (\(b),'1','4,2|7,1|29,1|4,1|3,1|2,14', '100.00', '2015-06-06 10:00:00','1')"
        let rc = db.execute(sql)
       
        
    }
   
    
    
}


    
  func CalculateBasket() -> Double{
    var data2 = db.query("SELECT  SUM(amount*price) as amount FROM SelectedItems LEFT JOIN MenuItems ON MenuItems.id=SelectedItems.ItemID ")
    
    if let task = data2[0]["amount"] {
        
     basket =    task.asDouble()
    }
    return basket;
}
    
    func emtyBasket(){
        let sqlDelete1 = "Delete FROM SelectedItems"
        println("SkRALD")
        db.execute(sqlDelete1)
       basket = 0.0
       NSNotificationCenter.defaultCenter().postNotificationName("refreshMyTableView", object: nil)
     }


    