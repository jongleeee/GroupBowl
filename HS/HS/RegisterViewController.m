//
//  RegisterViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/2/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.usernameField.Delegate = self;
    [self.emailField setDelegate:self];
    [self.passwordConfirmField setDelegate:self];
    [self.phoneNumber setDelegate:self];
    [self.nameField setDelegate:self];

    
    [self.passwordField setDelegate:self];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signupPressed:(id)sender {
    
    NSString *parse_usernameField = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *parse_emailField = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *parse_passwordField = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *parse_passwordConfirmField = [self.passwordConfirmField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *parse_nameField = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *parse_phoneField = [self.phoneNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    
    if ([parse_usernameField length] == 0 || [parse_emailField length] == 0 || [parse_passwordField length] == 0 || [parse_passwordConfirmField length] == 0
        || [parse_nameField length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please fill all informations!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    else if (![parse_passwordConfirmField isEqualToString:parse_passwordField])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Passwords do not match!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    else
    {
        PFUser *user = [PFUser user];
        user.username = parse_usernameField;
        user.password = parse_passwordField;
        user.email = parse_emailField;
        
        user[@"name"] = parse_nameField;
        user[@"phone"] = parse_phoneField;
        user[@"title"] = @"Member";
        
        NSString *userGroup = @"_GroupList";
        NSString *userGroupList = [parse_usernameField stringByAppendingString:userGroup];
        
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Username has already been taken!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                
                [alertView show];
                
            }
            else
            {
                
                appDelegate.currentUser = user;
                NSLog(@"this user reigstered: %@", appDelegate.currentUser);
                
                PFObject *userList = [PFObject objectWithClassName:userGroupList];
                
                [userList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error) {
                        
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                        
                    }
                    else {
                        NSLog(@"Performing REGISTERED!");
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }   ];
            }
        }];
        
        
//        if (appDelegate.currentUser != NULL)
//        {
//            PFObject *userList = [PFObject objectWithClassName:userGroupList];
//            
//            [userList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (error) {
//                    
//                    NSLog(@"Error: %@ %@", error, [error userInfo]);
//                    
//                }
//                else {
//                    NSLog(@"Performing REGISTERED!");
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                }
//            }];
//
//        }

        
    }
    
    
    
    
}
@end
