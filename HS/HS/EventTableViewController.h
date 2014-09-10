//
//  EventTableViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface EventTableViewController : UITableViewController {
    AppDelegate *appDelegate;
}

@property NSArray *eventItems;
@property PFObject *selectedEvent;


@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;
- (IBAction)addPressed:(id)sender;

@end
