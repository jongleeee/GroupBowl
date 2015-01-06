//
//  DetailEventViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "DetailEventViewController.h"
#import "EditDetailEventViewController.h"
#import "AttendingListTableViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Venmo-iOS-SDK/Venmo.h>

@interface DetailEventViewController ()

@end

@implementation DetailEventViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = [[UIApplication sharedApplication] delegate];

    self.attendListView = [[AttendingListTableView alloc] init];
    
    [self.attendList addSubview:self.attendListView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.attendList addSubview:self.refreshControl];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDate *date = self.detailEvent[@"date"];
    
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    
    [dformat setDateFormat:@"EEE, MMM d"];
    
    NSString *dateString = [dformat stringFromDate:date];
    
    self.date.text = dateString;
    self.contents.text = self.detailEvent[@"contents"];
    self.eventName.text = self.detailEvent[@"title"];
 
    
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    
    NSLog(@"1.0");
    
    PFRelation *relation = [self.detailEvent objectForKey:@"attend"];

    NSLog(@"1.2");
    
    PFQuery *query = [relation query];

    NSLog(@"1.4");
    
    [query orderByAscending:@"name"];

    NSLog(@"1.6");
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSLog(@"1.8");
        
        if (error) {
            NSLog(@"Error: %@", error);
            [self noData];
        }
        else
        {
            self.attendingList = objects;
            [self reload];
        }
    }];
    
    
}

- (void)noData {
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


- (void)reload {
    
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
    
    [self.attendList reloadData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    if ([self.attendingList count] == 0) {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No data is currently available. \n Please pull down to refresh.";
        messageLabel.textColor = [UIColor grayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
        [messageLabel sizeToFit];
        
        self.attendList.backgroundView = messageLabel;
        self.attendList.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return 0;
    } else {
        
        self.attendList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.attendList.backgroundView = nil;
        return 1;
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.attendingList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    PFObject *user = [self.attendingList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user[@"name"];
    
    if ([cell.textLabel.text isEqualToString:appDelegate.selectedGroupUser[@"name"]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (IBAction)editPressed:(id)sender {
    
    
    NSString *userTitle = [appDelegate.currentUser objectForKey:@"title"];
    if ([userTitle isEqualToString:@"Leader"])
    {
        [self performSegueWithIdentifier:@"editDetailEvent" sender:self];
    }
    else
    {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, must be a leader!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
    
    /*
    appDelegate.currentGroupName = appDelegate.selectedGroup[@"name"];
    
    PFQuery *query = [PFQuery queryWithClassName:appDelegate.currentGroupName];

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
                [self performSegueWithIdentifier:@"editDetailEvent" sender:self];
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



- (IBAction)attendPressed:(id)sender {
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setDimBackground:YES];
    
    if ([self.detailEvent[@"payment"] isEqualToString:@"YES"]) {
        
        
        float payAmountFloat = [self.detailEvent[@"fee"] floatValue];
        
        [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAppSwitch];
        
        [[Venmo sharedInstance] sendPaymentTo:self.detailEvent[@"venmoId"]
                                       amount:payAmountFloat*100 // this is in cents!
                                         note:self.eventName.text
                            completionHandler:^(VENTransaction *transaction, BOOL success, NSError *error) {
                                if (success) {
                                    
                                    PFRelation *attending = [self.detailEvent relationForKey:@"attend"];
                                    
                                    [attending addObject:appDelegate.selectedGroupUser];
                                    
                                    
                                    [self.detailEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                        if (error)
                                        {
                                            
                                        }
                                        else
                                        {
                                            
                                            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                                            
                                            
                                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attending" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                                            [alertView show];
                                            
                                            
                                        }
                                    }];
                                    

                                }
                                else {
                                    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                                    
                                    NSLog(@"Transaction failed with error: %@", [error localizedDescription]);
                                }
                            }];
        
        
    } else {
        
        PFRelation *attending = [self.detailEvent relationForKey:@"attend"];
        
        [attending addObject:appDelegate.selectedGroupUser];
        
        
        [self.detailEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error)
            {
                
            }
            else
            {
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];

                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attending" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alertView show];
                
                
            }
        }];

        
    }
    
    
}

- (IBAction)attendingListPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"attendingList" sender:self];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editDetailEvent"])
    {
        EditDetailEventViewController *viewController = (EditDetailEventViewController *)segue.destinationViewController;
        viewController.detailEvent = self.detailEvent;
    }
    else if ([segue.identifier isEqualToString:@"attendingList"])
    {
        AttendingListTableViewController *viewController = (AttendingListTableViewController *)segue.destinationViewController;
        viewController.event = self.detailEvent;
    }
}


- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.eventDetail.hidden = NO;
            self.attendList.hidden = YES;
            break;
        case 1:
            self.eventDetail.hidden = YES;
            self.attendList.hidden = NO;
            break;
        default:
            break;
    }
}


@end
