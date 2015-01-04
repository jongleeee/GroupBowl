//
//  MemberTableViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/1/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface MemberTableViewController : UITableViewController {
    AppDelegate *appDelegate;
    
}

@property (nonatomic, strong) PFRelation *relation;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) PFQuery *allFriends;
@property (nonatomic, strong) NSArray *friendsList;
@property (nonatomic, strong) PFObject *currentGroup;
@property (nonatomic, strong) PFUser *selectedUser;
@property (nonatomic, strong) NSString *currentName;
- (IBAction)addPressed:(id)sender;



@property (nonatomic, strong) NSString *currentMember;

@end
