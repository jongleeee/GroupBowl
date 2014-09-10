//
//  LoginViewController.h
//  HS
//
//  Created by Irene Lee on 7/22/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)loginPressed:(id)sender;

@end
