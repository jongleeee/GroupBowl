//
//  ChangePhoneNumberViewController.m
//  HS
//
//  Created by Jong Yun Lee on 12/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "ChangePhoneNumberViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ChangePhoneNumberViewController ()

@end

@implementation ChangePhoneNumberViewController

- (void)viewDidLoad {
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    [super viewDidLoad];

    self.currentPhoneNumber.text = appDelegate.currentPhoneNumber;
    
}


- (IBAction)updateNumber:(id)sender {

    if ([self.currentPhoneNumber.text isEqualToString:self.phoneNumber.text]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"cannot be same" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
 
        
    } else {
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setDetailsLabelText:@"Updating..."];
        [hud setDimBackground:YES];
        
        appDelegate.currentUser[@"phone"] = self.phoneNumber.text;
        
        [appDelegate.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                [self.navigationController popToRootViewControllerAnimated:NO];

            }
        }];
        
    }
    
}

@end
