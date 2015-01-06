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
        
        NSLog(@"1.0");
        [PFUser logInWithUsernameInBackground:parse_emailField password:parse_passwordField
                                        block:^(PFUser *user, NSError *error) {
                                            
                                            appDelegate.groups = user[@"groups"];
                                            appDelegate.currentEmail = user[@"email"];
                                            appDelegate.currentName = user[@"name"];
                                            appDelegate.currentPhoneNumber = user[@"phone"];
                                            
                                            NSLog(@"1.1");

                                            
                                            if (error) {
                                                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                                                
                                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Incorrect email or password!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                                                [alert show];
                                            } else {
                                                
                                                NSLog(@"1.2");

                                                
                                                appDelegate.currentUser = user;

                                                [self getGroupIfAny:user];
                                                

                                            }
                                        }];
        
    
    }

    
    
}


- (void)getGroupIfAny: (id)user {
    
    NSArray *tempGroup = user[@"groups"];

    NSLog(@"1.4");
    NSLog(@"%@", tempGroup);

    
    if ([tempGroup count] != 0) {
        
        appDelegate.currentGroupName = [tempGroup objectAtIndex:0];
        
        NSString *selectGroup = [appDelegate.currentGroupName stringByAppendingString:@"_Member"];
        
        PFQuery *selectQuery = [PFQuery queryWithClassName:selectGroup];
        [selectQuery whereKey:@"email" equalTo:appDelegate.currentEmail];
        
        NSLog(@"1.5");

        
        [selectQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                appDelegate.selectedGroupUser = object;
                appDelegate.currentName = object[@"name"];
                appDelegate.currentPhoneNumber = object[@"phone"];
                
                PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                [currentInstallation addUniqueObject:appDelegate.currentGroupName forKey:@"channels"];
                [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        
                        NSLog(@"1.7");

                        
                        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                        
                        [self.navigationController popToRootViewControllerAnimated:NO];

                    }
                }];
                
            } else {
                
                NSLog(@"1.9");

                
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];

                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please check your internet" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alerView show];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }];
    } else {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
    }

    
    
}

@end
