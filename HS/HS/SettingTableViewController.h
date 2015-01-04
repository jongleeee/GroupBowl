//
//  SettingTableViewController.h
//  HS
//
//  Created by Irene Lee on 7/22/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface SettingTableViewController : UITableViewController {
    AppDelegate *appDelegate;
}

- (IBAction)signOut:(id)sender;

@end
