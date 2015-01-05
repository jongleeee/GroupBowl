//
//  AddPaymentEventViewController.m
//  HS
//
//  Created by Jong Yun Lee on 12/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "AddPaymentEventViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Parse/Parse.h>

@interface AddPaymentEventViewController ()

@end

@implementation AddPaymentEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.eventTitle.delegate = self;
    self.eventDetail.delegate = self;
    self.feeAmount.delegate = self;
    
}






-(void)dismissKeyboard {
    [self.eventTitle resignFirstResponder];
    [self.eventDetail resignFirstResponder];
    [self.feeAmount resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)donePressed:(id)sender {
    
    if ([self.eventTitle.text length] == 0 || [self.eventDetail.text length] == 0 || [self.feeAmount.text length] == 0 || [self.venmoId.text length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please fill out title and contents!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alertView show];
    } else
    {

    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setDetailsLabelText:@"Updating..."];
    [hud setDimBackground:YES];
    
    NSString *parse_title = [self.eventTitle.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSNumber *parse_fee = @([self.feeAmount.text intValue]);
    
    NSString *parse_detail = [self.eventDetail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSDate *parse_date = self.eventDate.date;
    
    NSString *parse_venmo = [self.venmoId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    PFObject *event = [PFObject objectWithClassName:appDelegate.currentEvent];
    event[@"title"] = parse_title;
    event[@"fee"] = parse_fee;
    event[@"venmoId"] = parse_venmo;
    event[@"payment"] = @"YES";
    event[@"contents"] = parse_detail;
    event[@"date"] = parse_date;
    PFRelation *attending = [event relationForKey:@"attend"];

    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

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
                                           withMessage:@"New event!"];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];

            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];

    }
    
}
@end
