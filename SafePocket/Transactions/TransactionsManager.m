//
//  TransactionsManager.m
//  SafePocket
//
//  Created by Lucian Todorovici on 21/04/16.
//  Copyright © 2016 Lucian Todorovici. All rights reserved.
//

#import "TransactionsManager.h"

@implementation TransactionsManager

+(TransactionsManager*)sharedInstance
{
    static TransactionsManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TransactionsManager alloc] init];
    });
    return sharedInstance;
}

-(void)requestTransactions
{
    static const NSString *urlEndpointString = @"http://acipungasii.net16.net/getxml.php";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:(NSString*)urlEndpointString]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if(httpResponse.statusCode == 200 && data.length>0 && !error) {
            NSError *err = nil;
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
            if(array && !err) {
                NSLog(@"Array: %@",[self adaptArray:array]);
                _transactions = [NSMutableArray arrayWithArray:[self adaptArray:array]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"transactions_available" object:nil userInfo:@{@"transactions":[self adaptArray:array]}];
                });
            }
        }
    }];
    
    [dataTask resume];
}


-(NSArray*)adaptArray:(NSArray*)array
{
    NSMutableArray *resultArray = [NSMutableArray new];
    for(NSDictionary *dictionary in array){
        NSDictionary *dict = [dictionary objectForKey:@"CrDbTxnRqst"];
        // the first element in the subarray is the key of the subdictionary
        //if there us only one subelement in a subarray, then it is a simple label
        NSArray *keywordArray = @[@[@"Acct",@"PmryAcctNum"],@[@"Term",@"TermCity",@"TermCntr"]];
        
        
        NSMutableDictionary *resultDictionary = [NSMutableDictionary new];
        for (NSArray *array in keywordArray) {
            if(array.count == 1){
                [resultDictionary setObject:[dict objectForKey:array[0]] forKey:array[0]];
            }else if(array.count > 1){
                for(NSString *str in array){
                    if(![str isEqualToString:array[0]]){
                        [resultDictionary setObject:[[dict objectForKey:array[0]] objectForKey:str] forKey:str];
                    }
                }
            }
        }
        [resultArray addObject:resultDictionary];
    }
    return resultArray;
}



@end
