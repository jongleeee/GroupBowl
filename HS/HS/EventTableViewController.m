//
//  EventTableViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EventTableViewController.h"

@interface EventTableViewController ()

@end

@implementation EventTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    [query orderByDescending:@"date"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        else
        {
            self.eventItems = objects;
            NSLog(@"%@", self.eventItems);
            [self.tableView reloadData];


        }
    }];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    
    return [self.eventItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    static NSString *CellIdentifier = @"EventPrototype";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    //    Event *item = [self.eventItems objectAtIndex:indexPath.row];
    
    PFObject *event = [self.eventItems objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text = event[@"title"];
    
    NSDate *date = event[@"date"];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
    
    cell.detailTextLabel.text = dateString;
    
    //    cell.titleLabel.text = item.title;
    //    NSLog(@"%@", cell.titleLabel);
    //    NSLog(@"%@", cell.dateLabel);
    //    NSLog(@"%@", cell.contentLabel);
    //    NSDate *chosen = [item.datePicked date];
    //    NSString *dateString = [NSDateFormatter localizedStringFromDate:chosen
    //                                                          dateStyle:NSDateFormatterShortStyle
    //                                                          timeStyle:NSDateFormatterShortStyle];
    //    cell.dateLabel.text = dateString;
    //    cell.contentLabel.text = [NSString stringWithFormat:@"%@", item.content];
    //
    //    cell.clipsToBounds = YES;
    
    return cell;
}




@end
