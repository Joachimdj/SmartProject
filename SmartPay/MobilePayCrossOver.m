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

- (void) Buying: (NSString *)priceString   orderId:(NSString *)orderId{
   double price =[priceString doubleValue];
    NSString *receiptMessage = @"Tak for dit køb, nyd din ordre!";
    NSLog(orderId);
    //No need to start the appswitch if one or more parameters are missing
    if ((receiptMessage.length > 0) && (orderId.length > 0)) {
        [[MobilePayManager sharedInstance] beginMobilePaymentWithOrderId:orderId productPrice:price receiptMessage:receiptMessage error:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription
                                                            message:[NSString stringWithFormat:@"reason: %@, suggestion: %@",error.localizedFailureReason, error.localizedRecoverySuggestion]
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Install MobilePay",nil];
            [alert show];
        }];
    }
    
    
}

 

@end
