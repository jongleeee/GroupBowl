//
//  AppDelegate.h
//  HS
//
//  Created by Irene Lee on 7/10/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PFUser *currentUser;


@property (strong, nonatomic) PFObject *selectedGroup;
@property (strong, nonatomic) PFQuery *currentQuery;
@property (strong, nonatomic) NSString *currentUserName;
@property (strong, nonatomic) NSString *currentGroupName;
@property (strong, nonatomic) NSArray *groups;


// user information
@property (strong, nonatomic) NSString *currentEmail;
@property (strong, nonatomic) NSString *currentName;
@property (strong, nonatomic) NSString *currentPhoneNumber;
@property (strong, nonatomic) PFObject *selectedGroupUser;

// query information
@property (strong, nonatomic) NSString *currentAnnouncement;
@property (strong, nonatomic) NSString *currentEvent;
@property (strong, nonatomic) NSString *currentMember;

@end
