//
//  DetailMemberViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

@interface DetailMemberViewController : UIViewController <UIActionSheetDelegate, MFMessageComposeViewControllerDelegate> {
    AppDelegate *appDelegate;
}


@property (nonatomic, strong) PFUser *detailuser;

@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *phonenumber;
@property (strong, nonatomic) NSString *selectedGroupName;
@property (strong, nonatomic) NSString *selectedUserName;
@property (strong, nonatomic) NSString *selectedUserNAME;
- (IBAction)phonePressed:(id)sender;

- (void)makeCall:(NSString *)phoneNumber;

- (void)sendText:(NSString *)phoneNumber;

- (IBAction)editPressed:(id)sender;

@end
