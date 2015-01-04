//
//  AttendingListTableView.m
//  HS
//
//  Created by Jong Yun Lee on 12/30/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "AttendingListTableView.h"
#import <Parse/Parse.h>

@implementation AttendingListTableView


#pragma mark - Table view data source

- (void)viewDidLoad {
    
    NSLog(@"noethuonteuhontuh");

    
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.refreshControl];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Karisma_Event"];
    
    [query orderByAscending:@"date"];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        else
        {
            [refreshControl endRefreshing];
            [self reloadData];
        }
    }];

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
//    
//    PFRelation *relation = [self.event objectForKey:@"attend"];
//    NSLog(@"HERE");
//    PFQuery *query = [relation query];
//    NSLog(@"IS ThE");
//    [query orderByAscending:@"name"];
//    NSLog(@"ERROR:");
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        }
//        else
//        {
//            self.attendList = objects;
//            [self reloadData];
//        }
//    }];
    
    NSLog(@"ttttohnetuh");
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    return [self.attendList count];
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
//    PFObject *user = [self.attendList objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = user[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
