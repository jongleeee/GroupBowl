//
//  EventViewController.h
//  HS
//
//  Created by Irene Lee on 7/20/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface EventViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    AppDelegate *appDelegate;
    NSInteger selectedIndex;
}

@property NSMutableArray *eventItems;
@property PFObject *selectedEvent;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventDate;
- (IBAction)addPressed:(id)sender;


@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;
@property (nonatomic, strong) NSString *currentEvent;

@end
