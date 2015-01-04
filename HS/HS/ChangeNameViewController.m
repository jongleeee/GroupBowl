//
//  ChangeNameViewController.m
//  HS
//
//  Created by Jong Yun Lee on 12/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "ChangeNameViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ChangeNameViewController ()

@end

@implementation ChangeNameViewController

- (void)viewDidLoad {
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    [super viewDidLoad];
    
    self.currentName.text = appDelegate.currentName;
    
}



- (IBAction)updateName:(id)sender {
    
    if ([self.currentName.text isEqualToString:self.name.text]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"cannot be same" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        
        
    } else {
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setDetailsLabelText:@"Updating..."];
        [hud setDimBackground:YES];
        
        appDelegate.currentUser[@"name"] = self.name.text;
        
        [appDelegate.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                
                appDelegate.currentName = self.name.text;
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                [self.navigationController popToRootViewControllerAnimated:NO];
                
            }
        }];
        
    }
    
}
@end
