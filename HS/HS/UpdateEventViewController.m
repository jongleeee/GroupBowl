//
//  UpdateEventViewController.m
//  HS
//
//  Created by Irene Lee on 7/21/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UpdateEventViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>


@interface UpdateEventViewController ()

@end

@implementation UpdateEventViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    self.titleField.delegate = self;
    
}

-(void)dismissKeyboard {
    [self.contentsField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




- (IBAction)donePressed:(id)sender {
    
    NSLog(@"1");
    
    if ([self.titleField.text length] == 0 || [self.contentsField.text length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please fill out title and contents!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alertView show];
    } else
    {
    
        NSLog(@"1.2");
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setDetailsLabelText:@"Updating..."];
        [hud setDimBackground:YES];
        
        NSString *parse_title = [self.titleField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *parse_contents = [self.contentsField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSDate *parse_date = self.dateAndTime.date;
        
        NSLog(@"1.4");
        
        PFObject *event = [PFObject objectWithClassName:appDelegate.currentEvent];
        
        NSLog(@"%@", appDelegate.currentEvent);
        
        NSLog(@"1.5");
        
        event[@"title"] = parse_title;
        event[@"contents"] = parse_contents;
        event[@"date"] = parse_date;

        
        [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"1.8");
            if (error)
            {
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please check your internet" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alerView show];
                
            }
            else
            {
                PFPush *push = [[PFPush alloc] init];
                [push setChannel:appDelegate.currentGroupName];
            
                NSString *eventTitle = [@"Event: " stringByAppendingString:parse_title];
                [push setMessage:eventTitle];
                [push sendPushInBackground];
                

                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];

                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    

    
    //GroupBowl
    
    /*
    if ([self.titleField.text length] == 0 || [self.contentsField.text length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please fill out title and contents!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    else
    {
        
        NSString *parse_title = [self.titleField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *parse_contents = [self.contentsField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSDate *parse_date = self.dateAndTime.date;
        
        
        NSString *addEvent = @"_Event";
        NSString *updateEvent = [appDelegate.selectedGroup[@"name"] stringByAppendingString:addEvent];
        
        PFObject *event = [PFObject objectWithClassName:updateEvent];
        event[@"title"] = parse_title;
        event[@"contents"] = parse_contents;
        event[@"date"] = parse_date;
        
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
                                               withMessage:@"Event Added!"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
        
        
    }
     */
    }
}
@end
