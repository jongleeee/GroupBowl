//
//  AttendingListTableViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "AttendingListTableViewController.h"

@interface AttendingListTableViewController ()

@end

@implementation AttendingListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PFRelation *relation = [self.event objectForKey:@"attend"];
    NSLog(@"HERE");
    PFQuery *query = [relation query];
    NSLog(@"IS ThE");
    [query orderByAscending:@"name"];
    NSLog(@"ERROR:");
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
        else
        {
            self.attendList = objects;
            [self.tableView reloadData];
        }
    }];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.attendList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    PFObject *user = [self.attendList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}




@end
