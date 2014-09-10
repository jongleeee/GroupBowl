//
//  MainTabBarViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface MainTabBarViewController : UITabBarController {
    AppDelegate *appDelegate;
}


@property (nonatomic, readwrite) NSString *experiment;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) PFObject *selectedGroup;
@property (nonatomic, strong) NSArray *viewTabs;


@end
