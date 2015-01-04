//
//  NewsFeedTableViewController.h
//  HS
//
//  Created by Irene Lee on 7/17/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"


@interface NewsFeedTableViewController : UITableViewController {
    AppDelegate *appDelegate;

}

- (IBAction)updateNewsFeed:(id)sender;
@property (strong, nonatomic) NSMutableArray *newsList;
@property (strong, nonatomic) PFObject *selectedNews;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSString *currentAnnouncement;

@end
