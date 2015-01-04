//
//  EditDetailNewsViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EditDetailNewsViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface EditDetailNewsViewController ()

@end

@implementation EditDetailNewsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.detailTitle.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



-(void)dismissKeyboard {
    [self.contents resignFirstResponder];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.detailTitle.text = self.editNewsFeed[@"title"];
    self.contents.text = self.editNewsFeed[@"news"];
}



- (IBAction)updatePressed:(id)sender {
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setDetailsLabelText:@"Updating..."];
    [hud setDimBackground:YES];
    
    
    self.editNewsFeed[@"title"] = self.detailTitle.text;
    self.editNewsFeed[@"news"] = self.contents.text;
    
    [self.editNewsFeed saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        else
        {
            
            // Create our Installation query
            PFQuery *pushQuery = [PFInstallation query];
            [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
            
            // Send push notification to query
            [PFPush sendPushMessageToQueryInBackground:pushQuery
                                           withMessage:@"Announcement has been fixed!"];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
            
            [self.navigationController popToRootViewControllerAnimated:YES];

            
        }
    }];
    
    
}
@end
