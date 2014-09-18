//
//  LoginViewController.m
//  HS
//
//  Created by Irene Lee on 7/22/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self.emailField setDelegate:self];
    
    [self.passwordField setDelegate:self];

    self.navigationItem.hidesBackButton = YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}




- (IBAction)loginPressed:(id)sender {
    
    
    
    NSString *parse_emailField = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *parse_passwordField = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([parse_emailField length] == 0 || [parse_passwordField length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please fill all informations!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    
    else
    {
        
        [PFUser logInWithUsernameInBackground:parse_emailField password:parse_passwordField
                                        block:^(PFUser *user, NSError *error) {
                                            if (error) {
                                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Incorrect email or password!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                                                [alert show];
                                            } else {
                                                appDelegate.currentUser = user;
                                                [self.navigationController popToRootViewControllerAnimated:NO];
                                            }
                                        }];
        
    
    }

    
    
}
@end
