//
//  SelectGroupTableViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface SelectGroupTableViewController : UITableViewController {
    AppDelegate *appDelegate;
}

@property (nonatomic, strong) PFRelation *groupList;
@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, strong) PFUser *currentUser;

@end
