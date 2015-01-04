//
//  AddMemberViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MainTabBarViewController.h"
#import "AppDelegate.h"

@interface AddMemberViewController : UIViewController <UITextFieldDelegate> {
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet UITextField *memberEmail;
@property (nonatomic, strong) PFUser *currentUser;
@property (strong, nonatomic) PFObject *currentGroup;
@property (strong, nonatomic) PFUser *addUser;
- (IBAction)addPressed:(id)sender;


@property (strong, nonatomic) NSString *currentMember;
@property (strong, nonatomic) NSString *tempName;

@end
