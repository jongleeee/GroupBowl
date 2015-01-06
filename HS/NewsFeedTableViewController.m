//
//  NewsFeedTableViewController.m
//  HS
//
//  Created by Irene Lee on 7/17/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "News.h"
#import "NewsFeedTableViewController.h"
#import "UpdateNewsViewController.h"
#import "DetailNewsFeedViewController.h"
#import "AppDelegate.h"


@interface NewsFeedTableViewController ()
@end

@implementation NewsFeedTableViewController





- (void)viewDidLoad
{
 

    
    [super viewDidLoad];
    
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    appDelegate.currentUser = [PFUser currentUser];

    
    if (appDelegate.currentGroupName) {
        
        [self setRefresh];
        
    }
    

}




- (void)setRefresh {
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getLatestNewsFeed)
                  forControlEvents:UIControlEventValueChanged];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"%@", appDelegate.currentUser);
    
    if (!appDelegate.currentUser)
    {
        [self performSegueWithIdentifier:@"loginView" sender:self];
        return;
    }
    
    if (appDelegate.currentGroupName) {
        self.currentAnnouncement = [appDelegate.currentGroupName stringByAppendingString:@"_Announcement"];
        appDelegate.currentAnnouncement = self.currentAnnouncement;
    }
    
    if (!self.refreshControl && appDelegate.currentGroupName) {
        [self setRefresh];
    }
    
    if (!appDelegate.currentGroupName) {
        [self performSegueWithIdentifier:@"selectGroup" sender:self];

    }
    
    NSLog(@"%@", self.currentAnnouncement);
    
//
//    PFQuery *query = [PFQuery queryWithClassName:@"Karisma_Announcement"];
//    [query orderByDescending:@"updatedAt"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error)
//        {
//            NSLog(@"Error: %@", error);
//        }
//        else
//        {
//            self.newsList = objects;
//            NSLog(@"%@", self.newsList);
//
//            [self.tableView reloadData];
//        }
//    }];
    
    /*
    
    NSLog(@" HERKJERLKJWELKRJELKRJ: %@", appDelegate.currentUser);
    self.currentUser = appDelegate.currentUser;

    NSString *addNewsFeed = @"_NewsFeed";
    NSLog(@"SDFSF");
    NSLog(@"%@", self.currentUser);
    if (self.currentUser)
    {
        

        if (appDelegate.selectedGroup == nil)
        {
            self.newsList = nil;
            
      
        }
        else
        {

            
            NSLog(@"SELECTED GROUP EXIST");
            appDelegate.currentGroupName = appDelegate.selectedGroup[@"name"];
            NSString *currentNewsFeed = [appDelegate.currentGroupName stringByAppendingString:addNewsFeed];

            PFQuery *query = [PFQuery queryWithClassName:currentNewsFeed];
            [query orderByDescending:@"createdAt"];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                if (error)
                {
                    NSLog(@"Error: %@, %@", error, [error userInfo]);
                }
                else
                {
                    self.newsList = objects;
                    [self.tableView reloadData];
                }
            }];
            
      
        }
        [self.tableView reloadData];
        

        

    }
    else
    {
        NSLog(@"%@", appDelegate.currentUser);
        [self performSegueWithIdentifier:@"loginView" sender:self];

    }
    
    NSLog(@"ZXCVZCVZ: %d", [self.newsList count]);

   */
    
}


- (void)getLatestNewsFeed {
        
    PFQuery *query = [PFQuery queryWithClassName:self.currentAnnouncement];
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        else
        {
            self.newsList = objects;
            
            [self reloadData];
        }
    }];
    
}

- (void)reloadData {
    
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



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loginView"])
    {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    else if ([segue.identifier isEqualToString:@"detailNewsFeed"])
    {
        DetailNewsFeedViewController *viewController = (DetailNewsFeedViewController *) segue.destinationViewController;
        viewController.detailObject = self.selectedNews;
        
    }
    else if ([segue.identifier isEqualToString:@"updateNewsFeed"] && self.currentAnnouncement)
    {
        UpdateNewsViewController *viewController = (UpdateNewsViewController *) segue.destinationViewController;
        viewController.currentAnnouncement = self.currentAnnouncement;
    }
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.newsList count] == 0) {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        if (self.currentAnnouncement) {
            messageLabel.text = @"No data is currently available. \n Please pull down to refresh.";
        }
        else {
            messageLabel.text = @"Please register for a group.";
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

    
    return [self.newsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"News";
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    PFObject *item = nil;

        item = [self.newsList objectAtIndex:indexPath.row];
        cell.textLabel.text = item[@"title"];
        cell.detailTextLabel.text = item[@"news"];


    return cell;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedNews = [self.newsList objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"detailNewsFeed" sender:self];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here to do what you want when you hit delete
        [[self.newsList objectAtIndex:indexPath.row] deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error)
            {
                NSLog(@"Error: %@", error);
            }
            else
            {
                [self.newsList removeObjectAtIndex:[indexPath row]];
                [tableView reloadData];

            }
        }
        
         ];}
}




- (IBAction)updateNewsFeed:(id)sender {
    
    if (!self.currentAnnouncement) {
        return;
    }
    
    if ([appDelegate.selectedGroupUser[@"title"] isEqualToString:@"Leader"]) {
        [self performSegueWithIdentifier:@"updateNewsFeed" sender:self];
    } else {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, must be a leader!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
    
//    NSString *userTitle = [appDelegate.currentUser objectForKey:@"title"];
//    if ([userTitle isEqualToString:@"Leader"])
//    {
//        [self performSegueWithIdentifier:@"updateNewsFeed" sender:self];
//    }
//    else
//    {
//        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, must be a leader!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alerView show];
//    }
    
    // GroupBowl
    /*
    if (appDelegate.group == NO)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Must be in a group!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    NSLog(@"%@", appDelegate.currentUserName);
   
    NSString *groupName = appDelegate.currentGroupName;
    PFQuery *query = [PFQuery queryWithClassName:groupName];
    [query whereKey:@"userNAME" equalTo:appDelegate.currentUserName];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (error)
        {
            NSLog(@"error: %@", error);
        }
        else
        {
            if ([object[@"title"] isEqualToString:@"Leader"])
            {
                [self performSegueWithIdentifier:@"updateNewsFeed" sender:self];
            }
            else
             {
                 UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, permission is required" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                 [alerView show];
             }
        }
     }];
    
*/
 
    
    
    

    
}
@end
