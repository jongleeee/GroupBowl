//
//  EditMemberTableViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/1/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditMemberTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *allMembers;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSMutableArray *friends;

- (BOOL)isFriend:(PFUser *)user;

@end
