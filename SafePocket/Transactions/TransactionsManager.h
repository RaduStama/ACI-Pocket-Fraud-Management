//
//  TransactionsManager.h
//  SafePocket
//
//  Created by Lucian Todorovici on 21/04/16.
//  Copyright © 2016 Lucian Todorovici. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionsManager : NSObject

+(TransactionsManager*)sharedInstance;


-(void)requestTransactions;

@end
