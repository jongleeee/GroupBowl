//
//  SelectGroupTableViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "SelectGroupTableViewController.h"
#import "MainTabBarViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "NewsFeedTableViewController.h"


@interface SelectGroupTableViewController ()

@end

@implementation SelectGroupTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];

    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getLatestGroups)
                  forControlEvents:UIControlEventValueChanged];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
    

    
    self.groups = appDelegate.groups;
    
    
    
//        NSString *findList = @"_GroupList";
//        NSString *getList = [self.currentUser[@"username"] stringByAppendingString:findList];
//        
//        
//
//        PFQuery *query = [PFQuery queryWithClassName:getList];
//        [query orderByDescending:@"updatedAt"];
//        
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (error)
//            {
//                NSLog(@"error: %@", error);
//            }
//            else
//            {
//                self.groups = objects;
//                [self.tableView reloadData];
//            }
//        }];
        
    
}


- (void)getLatestGroups {
    
    NSLog(@"$$$$$$$$$$$$$$");
    NSLog(@"%@", appDelegate.currentEmail);
    
    PFQuery *currentUser = [PFUser query];
    [currentUser whereKey:@"email" equalTo:appDelegate.currentEmail];
    [currentUser getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            appDelegate.groups = object[@"groups"];
            self.groups = appDelegate.groups;
            
        }
        [self reloadData];
    }];

    
    NSLog(@"%@", appDelegate.currentUser);
    
    

}


- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    if ([self.groups count] == 0) {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"Please register for a group.";
        messageLabel.textColor = [UIColor grayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return 0;
        
    } else {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.backgroundView = nil;
        return 1;
        
    }
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.groups count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = [self.groups objectAtIndex:indexPath.row];
    
    if ([cell.textLabel.text isEqualToString:appDelegate.currentGroupName])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setDimBackground:YES];
    
    appDelegate.currentGroupName = [self.groups objectAtIndex:indexPath.row];
    
    NSString *currentUser = [appDelegate.currentGroupName stringByAppendingString:@"_Member"];
    
    PFQuery *query = [PFQuery queryWithClassName:currentUser];
    
    [query whereKey:@"email" equalTo:appDelegate.currentEmail];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            
            PFInstallation *currentInstallation = [PFInstallation currentInstallation];
            [currentInstallation addUniqueObject:appDelegate.currentGroupName forKey:@"channels"];
            [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                    
                    appDelegate.selectedGroupUser = object;
                    
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                } else {
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                    
                    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please check your internet" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alerView show];
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                    
                }
            }];
            
            
        }
    }];
    
}

@end
