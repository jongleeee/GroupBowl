//
//  RegisterViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/2/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>
#import <MBProgressHUD/MBProgressHUD.h>

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];



    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void)dismissKeyboard {
    [self.usernameField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordConfirmField resignFirstResponder];
    [self.phoneNumber resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.nameField resignFirstResponder];
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

- (IBAction)privacyPolicy:(id)sender {
    
    [self performSegueWithIdentifier:@"privacyPolicy" sender:self];
    
}

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
        [self dismissKeyboard];
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setDetailsLabelText:@"Signing in..."];
        [hud setDimBackground:YES];
        
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
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];

                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Welcome to GroupBowl" message:@"Thanks" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                
                [alertView show];

                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
                // GroupBowl
                /*
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
                 */
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
