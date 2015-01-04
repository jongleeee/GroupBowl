//
//  MemberTableViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/1/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "MemberTableViewController.h"
#import "DetailMemberViewController.h"

@interface MemberTableViewController ()

@end

@implementation MemberTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    self.currentUser = appDelegate.currentUser;
    self.currentName = self.currentUser[@"name"];

    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getLatestMembers)
                  forControlEvents:UIControlEventValueChanged];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if (appDelegate.currentGroupName) {
        self.currentMember = [appDelegate.currentGroupName stringByAppendingString:@"_Member"];
        appDelegate.currentMember = self.currentMember;
    }
   
        
//        PFQuery *query = [PFUser query];
//        [query orderByAscending:@"name"];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (error)
//            {
//                NSLog(@"error: %@", error);
//            }
//            else
//            {
//                self.friendsList = objects;
//                [self.tableView reloadData];
//            }
//        }];
        
        /*
        PFQuery *query = [PFQuery queryWithClassName:appDelegate.selectedGroup[@"name"]];
        
        [query whereKey:@"user" equalTo:@"user"];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error)
            {
                NSLog(@"error: %@", error);
            }
            else
            {
                self.friendsList = objects;
                [self.tableView reloadData];
            }
        }];
        
        */
    
    
    
  

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{


    if ([segue.identifier isEqualToString:@"detailView"])
    {
        DetailMemberViewController *viewController = (DetailMemberViewController *)segue.destinationViewController;

        viewController.detailuser = self.selectedUser;
        
        /*
        viewController.user = self.selectedUser[@"userNAME"];
        */
    }
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.friendsList count] == 0) {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        if (!self.currentMember) {
            messageLabel.text = @"Please register for a group.";
        } else {
            messageLabel.text = @"No data is currently available. \n Please pull down to refresh.";
        }
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
    
    return [self.friendsList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.friendsList objectAtIndex:indexPath.row];

    NSString *userID = user[@"name"];
    
    cell.textLabel.text = user[@"name"];

    
    if ([userID isEqualToString:self.currentName])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.selectedUser = [self.friendsList objectAtIndex:indexPath.row];

    
   
    [self performSegueWithIdentifier:@"detailView" sender:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}


- (IBAction)addPressed:(id)sender {
    
    if (!self.currentMember) {
        return;
    } else {
        [self performSegueWithIdentifier:@"addMember" sender:self];
    }
}

- (void)getLatestMembers {
    
    PFQuery *query = [PFQuery queryWithClassName:self.currentMember];
    [query orderByAscending:@"name"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"error: %@", error);
        }
        else
        {
            self.friendsList = objects;
            [self reloadData];
        }
    }];
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


@end
