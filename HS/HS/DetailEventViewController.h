//
//  DetailEventViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "AttendingListTableView.h"


BOOL check;
@interface DetailEventViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    AppDelegate *appDelegate;
}

@property (strong, nonatomic) IBOutlet UIButton *attendIcon;
@property (nonatomic, strong) PFObject *detailEvent;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UITextView *contents;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
- (IBAction)editPressed:(id)sender;
- (IBAction)attendPressed:(id)sender;
- (IBAction)attendingListPressed:(id)sender;



@property (strong, nonatomic) IBOutlet UITableView *attendList;
@property (strong, nonatomic) IBOutlet UIView *eventDetail;
@property (strong, nonatomic) IBOutlet UISegmentedControl *selectedSegmetIndex;
- (IBAction)segmentValueChanged:(UISegmentedControl *)sender;

@property (strong, nonatomic) AttendingListTableView *attendListView;
@property (strong, nonatomic) NSMutableArray *attendingList;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end
