//
//  SettingTableViewController.m
//  HS
//
//  Created by Irene Lee on 7/22/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *notificationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;

@end

@implementation SettingTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = [[UIApplication sharedApplication] delegate];

   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if ([cell.reuseIdentifier isEqualToString:@"password"])
    {
        
        [PFUser requestPasswordResetForEmailInBackground:appDelegate.currentEmail];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Request Sent" message:@"please check your email" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        
    } else if (!appDelegate.currentGroupName) {
        
    }else if ([cell.reuseIdentifier isEqualToString:@"phoneNumber"]) {
        [self performSegueWithIdentifier:@"changePhoneNumber" sender:self];
        
    } else if ([cell.reuseIdentifier isEqualToString:@"name"]) {
        [self performSegueWithIdentifier:@"changeName" sender:self];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
}





- (IBAction)signOut:(id)sender {

    [PFUser logOut];
    appDelegate.currentUser = nil;
    self.tabBarController.selectedIndex = 0;
}
@end
