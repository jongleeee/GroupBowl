//
//  DetailEventViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "DetailEventViewController.h"
#import "EditDetailEventViewController.h"

@interface DetailEventViewController ()

@end

@implementation DetailEventViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = [[UIApplication sharedApplication] delegate];

    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDate *date = self.detailEvent[@"date"];
    
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    
    [dformat setDateFormat:@"EEE, MMM d"];
    
    NSString *dateString = [dformat stringFromDate:date];
    
    self.date.text = dateString;
    self.contents.text = self.detailEvent[@"contents"];
    self.eventName.text = self.detailEvent[@"title"];
    
}




- (IBAction)editPressed:(id)sender {
    
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
                [self performSegueWithIdentifier:@"editDetailEvent" sender:self];
            }
            else
            {
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, permission is required" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alerView show];
            }
        }
    }];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editDetailEvent"])
    {
        EditDetailEventViewController *viewController = (EditDetailEventViewController *)segue.destinationViewController;
        viewController.detailEvent = self.detailEvent;
    }
}
@end
