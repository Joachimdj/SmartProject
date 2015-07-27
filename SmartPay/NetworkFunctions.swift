//
//  NetworkFunctions.swift
//  SmartPay
//
//  Created by Joachim Dittman on 27/07/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
import Alamofire

//Create user
//- Send Name, mobile nr., email and password
func   createUser(fullName: String,mobileNr: String, email: String, Password: String, completion: (result: Bool)-> Void){
    
    let parameters : [ String : String] = [
        "fullName": fullName,
        "mobileNr": mobileNr,
        "email": email,
        "password": Password
    ]
    
    Alamofire.request(.POST, "https://rollespil.dk/smartPay/api/userJson.php", parameters:parameters).responseJSON { (request, response, json, error) in
        println(response!.statusCode)
        if(response!.statusCode==200){
            println("færdig")
            completion(result: true)
        }
        else{
            completion(result: false)
        }}
}

//- If result 200, return user ID and success
//- If result 201, return user already created


//Login
//- Send email and password
func userLogin(email: String, Password: String, completion: (result: Bool)-> Void){
    
    let parameters : [ String : String] = [
        "email": email,
        "password": Password
    ]
    
    Alamofire.request(.POST, "https://rollespil.dk/smartPay/api/userJson.php", parameters:parameters).responseJSON { (request, response, json, error) in
        println(response!.statusCode)
        if(response!.statusCode==200){
         println("færdig")
            completion(result: true)
        }
        else{
           completion(result: false)
        }
  
    }
   
}
//- If result 200, return user ID and success
//- If result 303, user info don´t exist.
//- If result 304, email or password is not correct.

//Login with facebook
//- Send facebook user id and email
func loginWithFacebook(email: String, fbid: String, completion: (result: Bool)-> Void){
    let parameters : [ String : String] = [
        "email": email,
        "fbid": fbid
    ]
    
    Alamofire.request(.POST, "https://rollespil.dk/smartPay/api/userJson.php", parameters:parameters).responseJSON { (request, response, json, error) in
        println(response!.statusCode)
        if(response!.statusCode==200){
            println("færdig")
            completion(result: true)
        }
        else{
            completion(result: false)
        }
        
    }
    
    
}
//- If result 200, return user ID and success
//- If result 303, user info don´t exist.
//- If result 304, email or password is not correct.


// Get stores
// - Send coordinates
func getStores(long: String, lat: String, completion: (result: Bool)-> Void){
    let parameters : [ String : String] = [
        "long": long,
        "lat": lat
    ]
    
    Alamofire.request(.POST, "https://rollespil.dk/smartPay/api/StoreJson.php", parameters:parameters).responseJSON { (request, response, json, error) in
        println(response!.statusCode)
        if(response!.statusCode==200){
            println("færdig")
            completion(result: true)
        }
        else{
            completion(result: false)
        }
        
    }
    
}
//- If result 200, return String with stores and success
// - If result 303, No stores.


// Get menu by store

//- Send coordinates
func getMenuByStore(storeId: String, completion: (result: Bool)-> Void){
    let parameters : [ String : String] = [
        "storeId": storeId
    ]
    
    Alamofire.request(.POST, "https://rollespil.dk/smartPay/api/StoreJson.php", parameters:parameters).responseJSON { (request, response, json, error) in
        println(response!.statusCode)
        if(response!.statusCode==200){
            println("færdig")
            completion(result: true)
        }
        else{
            completion(result: false)
        }
        
    }

}
//- If result 200, return String with menu and success
//- If result 303, No stores.


//Get recipts by user ID
//- Send user ID
func getReciptsByUser(userId: String, completion: (result: Bool)-> Void){
    let parameters : [ String : String] = [
        "userId": userId
    ]
    
    Alamofire.request(.POST, "https://rollespil.dk/smartPay/api/ReciptsJson.php", parameters:parameters).responseJSON { (request, response, json, error) in
        println(response!.statusCode)
        if(response!.statusCode==200){
            println("færdig")
            completion(result: true)
        }
        else{
            completion(result: false)
        }
        
    }
}
//- If result 200, return String with recipts and success
//- If result 303, No new recipts.
