//
//  LoginViewController.m
//  HS
//
//  Created by Irene Lee on 7/22/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self.emailField setDelegate:self];
    
    [self.passwordField setDelegate:self];
    
    


}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

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
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setDetailsLabelText:@"Signing in..."];
        [hud setDimBackground:YES];
        
        
        [PFUser logInWithUsernameInBackground:parse_emailField password:parse_passwordField
                                        block:^(PFUser *user, NSError *error) {
                                            
                                            appDelegate.groups = user[@"groups"];
                                            appDelegate.currentEmail = user[@"email"];
                                            appDelegate.currentName = user[@"name"];
                                            appDelegate.currentPhoneNumber = user[@"phone"];
                                            
                                            
                                            
                                            if (error) {
                                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Incorrect email or password!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                                                [alert show];
                                            } else {
                                                
                                                appDelegate.currentUser = user;

                                                [self getGroupIfAny:user];
                                                
                                                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                                                
                                                [self.navigationController popToRootViewControllerAnimated:NO];
                                            }
                                        }];
        
    
    }

    
    
}


- (void)getGroupIfAny: (id)user {
    
    NSArray *tempGroup = user[@"groups"];
    if ([tempGroup count] != 0) {
        
        appDelegate.currentGroupName = [tempGroup objectAtIndex:0];
        
        NSString *selectGroup = [appDelegate.currentGroupName stringByAppendingString:@"_Member"];
        
        PFQuery *selectQuery = [PFQuery queryWithClassName:selectGroup];
        [selectQuery whereKey:@"email" equalTo:appDelegate.currentEmail];
        [selectQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                appDelegate.selectedGroupUser = object;
                appDelegate.currentName = object[@"name"];
                appDelegate.currentPhoneNumber = object[@"phone"];
                }
        }];
    }

    
    
}

@end
