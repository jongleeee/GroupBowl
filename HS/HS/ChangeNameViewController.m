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
    
    self.currentName.text = appDelegate.selectedGroupUser[@"name"];
    
}



- (IBAction)updateName:(id)sender {
    
    if ([self.currentName.text isEqualToString:self.name.text]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"cannot be same" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        
        
    } else {
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setDetailsLabelText:@"Updating..."];
        [hud setDimBackground:YES];
        
        appDelegate.selectedGroupUser[@"name"] = self.name.text;
        
        [appDelegate.selectedGroupUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                
                appDelegate.currentName = self.name.text;
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                [self.navigationController popToRootViewControllerAnimated:NO];
                
            } else {
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please check your internet" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alerView show];
                
            }
        }];
        
    }
    
}
@end
