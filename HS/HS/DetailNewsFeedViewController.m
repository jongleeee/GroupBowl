//
//  DetailNewsFeedViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "DetailNewsFeedViewController.h"
#import <Parse/Parse.h>
#import "EditDetailNewsViewController.h"

@interface DetailNewsFeedViewController ()

@end

@implementation DetailNewsFeedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.titleField.text = self.detailObject[@"title"];
    self.detailField.text = self.detailObject[@"news"];
}






- (IBAction)editPressed:(id)sender {
    
    if ([appDelegate.selectedGroupUser[@"title"] isEqualToString:@"Leader"]) {
        [self performSegueWithIdentifier:@"editDetailNewsFeed" sender:self];

    } else {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, must be a leader!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
    
    
//    NSString *title = [appDelegate.currentUser objectForKey:@"title"];
//    if ([title isEqualToString:@"Leader"])
//    {
//        [self performSegueWithIdentifier:@"editDetailNewsFeed" sender:self];
//    }
//    else
//    {
//        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, must be a leader" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alerView show];
//        
//    }
    
    // GroupBowl
    /*
    appDelegate.currentGroupName = appDelegate.selectedGroup[@"name"];
    
    PFQuery *query = [PFQuery queryWithClassName:appDelegate.currentGroupName];
    
    [query whereKey:@"userNAME" equalTo:appDelegate.currentUserName];
    
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (error)
        {
            NSLog(@"error: %@", error);
        }
        else
        {
            if ([object[@"title"] isEqualToString:@"Leader"])
            {
                [self performSegueWithIdentifier:@"editDetailNewsFeed" sender:self];
            }
            else
            {
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, permission is required" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alerView show];
            }
        }
    }];
     */
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editDetailNewsFeed"])
    {
        EditDetailNewsViewController *viewController = (EditDetailNewsViewController *) segue.destinationViewController;
        viewController.editNewsFeed = self.detailObject;
    }
}


@end
