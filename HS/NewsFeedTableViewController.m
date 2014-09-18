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
    
    
    NSLog(@"%@", appDelegate.currentUser);


}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];

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
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (appDelegate.selectedGroup == nil)
    {
        NSLog(@"NO CELL HERE");

        return 0;
    }

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (appDelegate.selectedGroup == nil)
    {
        NSLog(@"NO CELL");
        return 0;
    }
    
    return [self.newsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"NO LIST FOUND");
    static NSString *CellIdentifier = @"News";
    NSLog(@"DSFSDFSDFSFS");
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



- (IBAction)updateNewsFeed:(id)sender {
    
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
    

    
}
@end
