//
//  UpdateNewsViewController.m
//  HS
//
//  Created by Irene Lee on 7/17/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "UpdateNewsViewController.h"
#import "News.h"
#import <Parse/Parse.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface UpdateNewsViewController ()


@end

@implementation UpdateNewsViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];



    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.titleField.delegate = self;
    
    NSLog(@"onethuotneub %@", self.currentAnnouncement);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



-(void)dismissKeyboard {
    [self.textField resignFirstResponder];
}

- (IBAction)updatePressed:(id)sender {
    
    
    if ([self.titleField.text length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please fill out the title!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    else if ([self.textField.text length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please fill out the contents!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    else
    {
        [self dismissKeyboard];
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setDetailsLabelText:@"Updating..."];
        [hud setDimBackground:YES];
        
        NSString *parse_title = [self.titleField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *parse_news = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        PFObject *announcement = [PFObject objectWithClassName:appDelegate.currentAnnouncement];
        
        announcement[@"title"] = parse_title;
        announcement[@"news"] = parse_news;
        [announcement saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error)
            {
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please check your internet" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alerView show];
                                
                
                NSLog(@"Error: %@", error);
            }
            else
            {
                
                PFPush *push = [[PFPush alloc] init];
                [push setChannel:appDelegate.currentGroupName];
            

                [push setMessage:parse_title];
                [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                

//                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
//
//                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
        // GroupBowl
        /*
        NSString *parse_title = [self.titleField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *parse_news = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *getNewsFeed = @"_NewsFeed";
        NSString *allNewsFeed = [appDelegate.selectedGroup[@"name"] stringByAppendingString:getNewsFeed];
        
        
        PFObject *newsFeed = [PFObject objectWithClassName:allNewsFeed];
        newsFeed[@"title"] = parse_title;
        newsFeed[@"news"] = parse_news;
        
        [newsFeed saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error)
            {
                NSLog(@"Error: %@", error);
            }
        }];
        
        // Create our Installation query
        PFQuery *pushQuery = [PFInstallation query];
        [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
        
        // Send push notification to query
        [PFPush sendPushMessageToQueryInBackground:pushQuery
                                       withMessage:@"Announcement!"];
        
            [self.navigationController popToRootViewControllerAnimated:YES];
*/
        
    }
    
}

- (IBAction)cancelPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
