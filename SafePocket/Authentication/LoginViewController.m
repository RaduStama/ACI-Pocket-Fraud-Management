//
//  LoginViewController.m
//  SafePocket
//
//  Created by Lucian Todorovici on 18/04/16.
//  Copyright © 2016 Lucian Todorovici. All rights reserved.
//

#import "LoginViewController.h"
#import "TransactionsManager.h"
#import "TransactionsViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_userTextField setText:@"test"];
    [_passTextField setText:@"pungasii"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// end editing when then user taps the screen
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing];
}

-(void)endEditing
{
    [_userTextField endEditing:YES];
    [_passTextField endEditing:YES];
}

// the logic happening when the user taps the login button
- (IBAction)loginBtnPressed:(UIButton *)sender
{
    //register a vc callback for the moment the transactions are available
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTransactions:) name:@"transactions_available" object:nil];
    [[TransactionsManager sharedInstance] requestTransactions];
}

-(void)showTransactions:(NSNotification*)notif
{
    UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"transactionsVC"];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
