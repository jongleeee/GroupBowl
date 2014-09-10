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

    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if ([cell.reuseIdentifier isEqualToString:@"editProfile"])
    {
        [self performSegueWithIdentifier:@"editProfilePressed" sender:self];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
}

@end
