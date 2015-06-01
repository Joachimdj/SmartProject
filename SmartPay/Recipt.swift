//
//  Recipt.swift
//  SmartPay
//
//  Created by Joachim Dittman on 27/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit

    
    struct Recipt {
        let id : Int64
        let user : String
        let MenuItems : NSDictionary
        let paymentAmount : Int32
        let paymentDate : NSDate
        let storeId : Int64
    }
    
 