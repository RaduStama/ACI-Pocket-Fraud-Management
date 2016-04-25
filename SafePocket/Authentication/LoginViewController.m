//
//  LoginViewController.m
//  SafePocket
//
//  Created by Lucian Todorovici on 18/04/16.
//  Copyright © 2016 Lucian Todorovici. All rights reserved.
//

#import "LoginViewController.h"
#import "TransactionsManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing];
}

-(void)endEditing
{
    [_userTextField endEditing:YES];
    [_passTextField endEditing:YES];
}

- (IBAction)loginBtnPressed:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTransactions:) name:@"transactions_available" object:nil];
    [[TransactionsManager sharedInstance] requestTransactions];
    //animate something
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *transactionsViewController = [storyboard instantiateViewControllerWithIdentifier:@"transactionsVC"];
    [self presentViewController:transactionsViewController animated:YES completion:nil];
     */
}

-(void)showTransactions:(NSNotification*)notif
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIViewController *controller = [UIViewController new];
        CGRect frame = CGRectMake(30, 30, 200, 50);
        for (NSString *key in notif.userInfo.allKeys){
            UITextView *textView = [UITextView new];
            [textView setText:[notif.userInfo objectForKey:key]];
            textView.frame = frame;
            frame.origin.y = frame.origin.y + 60;
            [controller.view addSubview:textView];
        }
        [self presentViewController:controller animated:YES completion:nil];
    });
}

@end
