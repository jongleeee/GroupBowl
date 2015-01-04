//
//  EditDetailEventViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EditDetailEventViewController.h"

@interface EditDetailEventViewController ()

@end

@implementation EditDetailEventViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.editTitle.delegate = self;
    
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
    [self.editContents resignFirstResponder];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.editTitle.text = self.detailEvent[@"title"];
    self.editContents.text = self.detailEvent[@"contents"];
    
}



- (IBAction)updatePressed:(id)sender {

    self.detailEvent[@"title"] = self.editTitle.text;
    self.detailEvent[@"contents"] = self.editContents.text;
    self.detailEvent[@"date"] = self.editDate.date;
    
    [self.detailEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        else
        {
            PFQuery *pushQuery = [PFInstallation query];
            [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
            
            // Send push notification to query
            [PFPush sendPushMessageToQueryInBackground:pushQuery
                                           withMessage:@"Event has been fixed!"];

            
            [self.navigationController popToRootViewControllerAnimated:YES];

        }
    }];
    


}
@end
