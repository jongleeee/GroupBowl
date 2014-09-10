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


    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    
    if (appDelegate.group == NO)
    {
        
    }
    else
    {
        
        
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
        
        
    }
    
    
  

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{


    if ([segue.identifier isEqualToString:@"detailView"])
    {
        DetailMemberViewController *viewController = (DetailMemberViewController *)segue.destinationViewController;

        viewController.user = self.selectedUser[@"userNAME"];
        
    }
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    
    cell.textLabel.text = user[@"username"];

    
    if ([userID isEqualToString:self.currentName])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
    
    if (appDelegate.group == NO)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Must be in a group!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    else
    {
        [self performSegueWithIdentifier:@"addMember" sender:self];
    }
    
}
@end
