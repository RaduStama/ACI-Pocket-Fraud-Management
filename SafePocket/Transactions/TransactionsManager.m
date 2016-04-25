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
    static NSString *urlEndpointString = @"http://acipungasii.net16.net/getxml.php";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEndpointString]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if(httpResponse.statusCode == 200 && data.length>0 && !error) {
            NSError *err = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
            if(dict && !err) {
                NSLog(@"Dictionary: %@",dict);
            }
        }
    }];
    
    [dataTask resume];
}

@end
