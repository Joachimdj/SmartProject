//
//  ProductListViewController.m
//  MobilePayFruitShop
//
//  Created by Thomas Fekete Christensen on 18/03/14.
//  Copyright (c) 2014 Thomas Fekete Christensen. All rights reserved.
//

#import "MobilePayCrossOver.h"
#import "MobilePayManager.h"




@implementation MobilePayCrossOver



- (void) Buying {
    NSLog(@"In buy method now");
    
    NSString *receiptMessage = @"Tak for dit køb, nyd din frugt!";
    NSString *orderId = @"123456";
    if ( (receiptMessage.length > 0) && (orderId.length > 0)) {
         NSLog(@"In buy method now1");
      [[MobilePayManager sharedInstance] beginMobilePaymentWithOrderId:orderId productPrice:20.0 receiptMessage:receiptMessage error:^(NSError *error) {
          
       
               NSLog(@"In buy method now2");
        }]; 
        
  
        NSLog(@"In buy method now2");
    }else{
        NSLog(@"Error");
    }
    

}





@end
