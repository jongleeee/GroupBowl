//
//  RegisterViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/2/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface RegisterViewController : UIViewController <UITextFieldDelegate> {
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *passwordConfirmField;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;




- (IBAction)signupPressed:(id)sender;

@end
