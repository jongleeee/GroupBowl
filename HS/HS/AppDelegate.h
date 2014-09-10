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
@property BOOL group;
@property (strong, nonatomic) NSString *currentUserName;
@property (strong, nonatomic) NSString *currentGroupName;

@end
