//
//  DetailMemberViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "DetailMemberViewController.h"
#import "EditDetailMemberViewController.h"

@interface DetailMemberViewController ()

@end

@implementation DetailMemberViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];

   
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.phonenumber.text = self.detailuser[@"phone"];
    self.email.text = self.detailuser[@"email"];
    self.username.text = self.detailuser[@"name"];


}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.email.text = nil;
    self.phonenumber.text = nil;
    self.username.text = nil;
}

- (IBAction)phonePressed:(id)sender {
    
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Text", @"Call", nil];
    
    [action showInView:self.view];
    
    
    
    

}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex == 0)
    {
        [self sendText:self.phonenumber.text];

    }
    else if (buttonIndex == 1)
    {
        [self makeCall:self.phonenumber.text];

    }

}

- (void)makeCall:(NSString *)phoneNumber
{
    NSString *number = [NSString stringWithFormat:@"%@",phoneNumber];
    NSURL* callUrl=[NSURL URLWithString:[NSString   stringWithFormat:@"telprompt:%@",number]];
    
    //check  Call Function available only in iphone
    if([[UIApplication sharedApplication] canOpenURL:callUrl])
    {
        [[UIApplication sharedApplication] openURL:callUrl];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ALERT" message:@"This function is only available on the iPhone"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)sendText:(NSString *)phoneNumber
{
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    
    messageVC.body = nil;
    messageVC.recipients = @[phoneNumber];
    messageVC.messageComposeDelegate = self;
    
    [self presentViewController:messageVC animated:NO completion:NULL];
}

- (IBAction)editPressed:(id)sender {
    
    if ([appDelegate.selectedGroupUser[@"title"] isEqualToString:@"Leader"]) {
        [self performSegueWithIdentifier:@"editDetailMember" sender:self];
    } else {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, must be a leader!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
    
    
    
//    NSString *title = appDelegate.currentUser[@"title"];
//    
//    if ([title isEqualToString:@"Leader"])
//    {
//        [self performSegueWithIdentifier:@"editDetailMember" sender:self];
//
//    }
//    else
//    {
//        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, must be a leader" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alerView show];
//    }
    
    
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
                [self performSegueWithIdentifier:@"editDetailMember" sender:self];
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
    if ([segue.identifier isEqualToString:@"editDetailMember"])
    {
        EditDetailMemberViewController *viewController = (EditDetailMemberViewController *) segue.destinationViewController;
        viewController.groupName = self.selectedGroupName;
        viewController.userName = self.selectedUserName;
        viewController.userID = self.selectedUserNAME;
    }
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
//    [self dismissViewControllerAnimated:YES completion:NULL];

}

@end
