//
//  AttendingListTableViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AttendingListTableViewController : UITableViewController

@property (nonatomic, strong) PFObject *event;
@property (nonatomic, strong) NSArray *attendList;



@end
