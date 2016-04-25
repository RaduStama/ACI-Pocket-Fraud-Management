//
//  TransactionsManager.m
//  SafePocket
//
//  Created by Lucian Todorovici on 21/04/16.
//  Copyright © 2016 Lucian Todorovici. All rights reserved.
//

#import "TransactionsManager.h"

@implementation TransactionsManager

-(TransactionsManager*)getSharedInstance
{
    static TransactionsManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TransactionsManager alloc] init];
    });
    return sharedInstance;
}



@end
