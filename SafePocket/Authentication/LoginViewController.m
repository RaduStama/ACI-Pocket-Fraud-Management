//
//  LoginViewController.m
//  SafePocket
//
//  Created by Lucian Todorovici on 18/04/16.
//  Copyright © 2016 Lucian Todorovici. All rights reserved.
//

#import "LoginViewController.h"

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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *transactionsViewController = [storyboard instantiateViewControllerWithIdentifier:@"transactionsVC"];
    [self presentViewController:transactionsViewController animated:YES completion:nil];
}


@end
