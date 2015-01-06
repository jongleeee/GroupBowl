//
//  EventViewController.m
//  HS
//
//  Created by Irene Lee on 7/20/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EventViewController.h"
#import "PDTSimpleCalendar.h"
#import "UpdateEventViewController.h"
#import "Event.h"
#import "EventCell.h"
#import "DetailEventViewController.h"
#import "CustomCellTableViewCell.h"
#import "MainTabBarViewController.h"

@interface EventViewController ()

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)calendarButtonPressed:(UIBarButtonItem *)sender;
- (void)getLatestEvents;
@property (nonatomic, weak) UIViewController *currentchildViewController;

@end

@implementation EventViewController


- (IBAction)goBackToList:(UIStoryboardSegue *)segue
{

}

- (void)viewDidLoad
{
    self.eventItems = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
    //no index is expanded in default
    selectedIndex = -1;
    
    
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
                            action:@selector(getLatestEvents)
                  forControlEvents:UIControlEventValueChanged];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (appDelegate.currentGroupName) {
        self.currentEvent = [appDelegate.currentGroupName stringByAppendingString:@"_Event"];
        appDelegate.currentEvent = self.currentEvent;
    }
    
    if (!self.refreshControl && appDelegate.currentGroupName) {
        [self setRefresh];
    }
        
//        PFQuery *query = [PFQuery queryWithClassName:@"Karisma_Event"];
//        
//        [query orderByAscending:@"date"];
//
//        
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (error)
//            {
//                NSLog(@"Error: %@", error);
//            }
//            else
//            {
//                self.eventItems = objects;
//                [self.tableView reloadData];
//            }
//        }];
        
        /*
        NSString *addEvent = @"_Event";
        NSString *currentEvent = [appDelegate.selectedGroup[@"name"] stringByAppendingString:addEvent];
        
        PFQuery *query = [PFQuery queryWithClassName:currentEvent];
    
        
        [query orderByAscending:@"date"];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error)
            {
                NSLog(@"Error: %@", error);
            }
            else
            {
                self.eventItems = objects;
                [self.tableView reloadData];
            }
        }];
         */
    
    
   
    
}


    
    
- (void)getLatestEvents {
    
    PFQuery *query = [PFQuery queryWithClassName:self.currentEvent];
    [query whereKey:@"date" greaterThanOrEqualTo:[NSDate date]];
    [query orderByAscending:@"date"];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        else
        {
            self.eventItems = objects;
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    if ([self.eventItems count] == 0) {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        if (!self.currentEvent) {
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
    // Return the number of rows in the section.
    return [self.eventItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"EventPrototype";
    CustomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
//    Event *item = [self.eventItems objectAtIndex:indexPath.row];
    
    PFObject *event = [self.eventItems objectAtIndex:indexPath.row];
    

    
    cell.eventTitle.text = event[@"title"];
    
    NSDate *date = event[@"date"];
  
    
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    
    [dformat setDateFormat:@"EEE, MM/d"];
    
    NSString *dateString = [dformat stringFromDate:date];
    
    cell.eventDate.text = dateString;

    
//    NSDate *date = [dformat dateFromString:dateString];
//    
////    EEE, MMM d
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter stringFromDate:date];
//    
//    //Optionally for time zone converstions
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
//    
//    NSString *stringFromDate = [formatter stringFromDate:myNSDateInstance];
    
    
    
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndex == indexPath.row) {
        return 110;
    } else {
        return 44;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//
////delegate to calculate height
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.prototypeCell layoutIfNeeded];
//    CGSize eventSize = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return eventSize.height + 1;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    //User taps expanded Row
//    if (selectedIndex == indexPath.row) {
//        selectedIndex = -1;
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//    //User taps different row
//    else if (selectedIndex != -1) {
//        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
//        selectedIndex = indexPath.row;
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else {
//        //User taps new row with none expanded
//        selectedIndex = indexPath.row;
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }

    
    
    self.selectedEvent = [self.eventItems objectAtIndex:indexPath.row];
    

        
    [self performSegueWithIdentifier:@"detailEvent" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];


    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here to do what you want when you hit delete
        [[self.eventItems objectAtIndex:indexPath.row] deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error)
            {
                NSLog(@"Error: %@", error);
            }
            else
            {
                [self.eventItems removeObjectAtIndex:[indexPath row]];
                [tableView reloadData];
                
            }
        }
         
         ];}
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
//    if (appDelegate.groups == NO)
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Must be in a group!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alertView show];
//        
//        return;
//    }
    
    if ([segue.identifier isEqualToString:@"detailEvent"])
    {
        DetailEventViewController *viewController = (DetailEventViewController *)segue.destinationViewController;
        viewController.detailEvent = self.selectedEvent;
        
    }
    
   
}


- (UITableViewController *)calendarEventList
{
    UITableViewController *viewController = [UITableViewController new];
    viewController.view.frame = CGRectInset(self.view.bounds, 0, 165);

    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.view.layer.borderWidth = 6;
    viewController.view.layer.cornerRadius = 8;
    viewController.view.layer.borderColor = (__bridge CGColorRef)([UIColor clearColor]);
    viewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    viewController.view.layer.shadowOffset = CGSizeZero;
    viewController.view.layer.shadowOpacity = 0.5;
    
    return viewController;
}
- (IBAction)calendarButtonPressed:(UIBarButtonItem *)sender {
    PDTSimpleCalendarViewController *calendar = [[PDTSimpleCalendarViewController alloc] init];
    
    calendar.firstDate = [NSDate date];
    
    //contained viewcontroller event tableview
    UITableViewController *viewController = [self calendarEventList];
//    viewController.view.frame = CGRectMake(self.view.frame.size.width - viewController.view.frame.size.width, self.view.frame.size.height - viewController.view.frame.size.height, viewController.view.frame.size.width, viewController.view.frame.size.height);
    viewController.view.frame = CGRectMake(self.view.frame.size.width, self.view.frame.size.height, viewController.view.frame.size.width, viewController.view.frame.size.height);
    [calendar addChildViewController:viewController];
    [calendar.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:calendar];
    self.currentchildViewController = viewController;
    //set header
    [calendar setTitle:@"Calendar"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(navBack:)];
    calendar.navigationItem.leftBarButtonItem = backButton;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(navAdd:)];
    calendar.navigationItem.rightBarButtonItem = addButton;
    [self.navigationController pushViewController:calendar animated:YES];
    //if date is selected, see from eventitems if the date matches. if yes show in tableview & reload
}

- (IBAction)navBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)navAdd:(UIBarButtonItem *)sender {
    
    if (!self.currentEvent) {
        return;
    }
    
    [self performSegueWithIdentifier:@"addEvent" sender:sender];
}


- (IBAction)addPressed:(id)sender {

    if (!self.currentEvent) {
        return;
    }
    
    if ([appDelegate.selectedGroupUser[@"title"] isEqualToString:@"Leader"]) {
        [self performSegueWithIdentifier:@"addEvent" sender:self];
    } else {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, must be a leader!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alerView show];
    }
    
    
//    NSString *userTitle = [appDelegate.currentUser objectForKey:@"title"];
//    if ([userTitle isEqualToString:@"Leader"])
//    {
//        [self performSegueWithIdentifier:@"addEvent" sender:self];
//    }
//    else
//    {
//        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Sorry, must be a leader!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alerView show];
//    }
    
    /*
    appDelegate.currentGroupName = appDelegate.selectedGroup[@"name"];
        PFQuery *query = [PFQuery queryWithClassName:appDelegate.currentGroupName];
    NSLog(@"%@", appDelegate.currentGroupName);
    NSLog(@"%@", appDelegate.currentUserName);
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
                     [self performSegueWithIdentifier:@"addEvent" sender:self];
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
