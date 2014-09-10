//
//  SelectGroupTableViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "SelectGroupTableViewController.h"
#import "MainTabBarViewController.h"

@interface SelectGroupTableViewController ()

@end

@implementation SelectGroupTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    self.currentUser = appDelegate.currentUser;

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
    if (appDelegate.selectedGroup == nil)
    {
        
    }
    else
    {
    
    
        NSString *findList = @"_GroupList";
        NSString *getList = [self.currentUser[@"username"] stringByAppendingString:findList];
        
        

        PFQuery *query = [PFQuery queryWithClassName:getList];
        [query orderByDescending:@"updatedAt"];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error)
            {
                NSLog(@"error: %@", error);
            }
            else
            {
                self.groups = objects;
                [self.tableView reloadData];
            }
        }];
        
        }
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
    return [self.groups count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *groupName = [self.groups objectAtIndex:indexPath.row];
    
    cell.textLabel.text = groupName[@"name"];
    
    if ([appDelegate.selectedGroup[@"name"] isEqualToString:groupName[@"name"]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    appDelegate.selectedGroup = [self.groups objectAtIndex:indexPath.row];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
