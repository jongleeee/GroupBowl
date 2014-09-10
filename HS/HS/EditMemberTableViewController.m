//
//  EditMemberTableViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/1/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EditMemberTableViewController.h"

@interface EditMemberTableViewController ()

@end

@implementation EditMemberTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self viewWillAppear:animated];
    
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@, %@", error, [error userInfo]);
        }
        else
        {
            self.allMembers = objects;
            [self.tableView reloadData];
        }
    }];
    
    self.currentUser = [PFUser currentUser];
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
    return [self.allMembers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.allMembers objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];

    if ([self isFriend:user])
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        for (PFUser *friend in self.friends)
        {
            if ([friend.objectId isEqualToString:user.objectId])
            {
                [self.friends removeObject:friend];
                break;
            }
        }
        
        [friendsRelation removeObject:user];
        
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.friends addObject:user];
        [friendsRelation addObject:user];
    
    }
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    PFUser *user = [self.allMembers objectAtIndex:indexPath.row];

    
    if ([self isFriend:user])
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    [friendsRelation addObject:user];
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@, %@", error, [error userInfo]);
        }
    }];
    
    
    
}


#pragma mark - Helper Methods

- (BOOL)isFriend:(PFUser *)user
{
    for (PFUser *friends in self.friends)
    {
        if ([friends.objectId isEqualToString:user.objectId])
        {
            return YES;
        }
    }
    return NO;
}

@end
