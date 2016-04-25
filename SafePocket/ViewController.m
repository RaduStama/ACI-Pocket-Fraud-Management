//
//  ViewController.m
//  SafePocket
//
//  Created by Lucian Todorovici on 14/04/16.
//  Copyright © 2016 Lucian Todorovici. All rights reserved.
//

#import "ViewController.h"
@import LocalAuthentication;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self animateArrow];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self authenticateWithBiometrics];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)authenticateWithBiometrics
{
    LAContext *authenticationContext = [[LAContext alloc] init];
    NSError *error = nil;
    
    if(![authenticationContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Touch ID" message:@"Touch ID is not available" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
            UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"segue" source:self destination:loginViewController performHandler:^(){
                [self presentViewController:loginViewController animated:YES completion:nil];
            }];
            [segue perform];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        [authenticationContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"SafePocket needs you to authenticate" reply:^(BOOL success, NSError * _Nullable error) {
            if(success && !error){
                NSLog(@"Success!");
            }
        }];
        
    }

}

-(void)animateArrow
{
    [UIView animateWithDuration:0.5 animations:^{
        self.arrowImageView.center = CGPointMake(self.arrowImageView.center.x,self.arrowImageView.center.y+15);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.arrowImageView.center = CGPointMake(self.arrowImageView.center.x,self.arrowImageView.center.y-15);
        } completion:^(BOOL finished) {
            [self animateArrow];
        }];
    } ];
}

- (IBAction)goToLoginPressed:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    [self presentViewController:loginViewController animated:YES completion:nil];
}



@end
