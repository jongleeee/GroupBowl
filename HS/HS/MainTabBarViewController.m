//
//  MainTabBarViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];

    
    NSLog(@"YES: %@", appDelegate.currentUser[@"username"]);
    
    if (appDelegate.selectedGroup == NULL)
    {
        NSLog(@"EMTPY");
    }
    
//    self.viewTabs = self.viewControllers;
//
//    
//    self.currentUser = [PFUser currentUser];
//    
//    
//    
//    NSLog(@"Hello: %@", self.currentUser[@"username"]);
//    
//    PFRelation *groupSelect = [self.currentUser objectForKey:@"groupRelations"];
//    PFQuery *query = [groupSelect query];
//    [query orderByDescending:@"updateAt"];
//    if (query == NULL)
//    {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        return;
//    }
//    else
//    {
//
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error)
//        {
//            NSLog(@"error: %@", error);
//        }
//        else
//        {
//            if ([objects count] == 0)
//            {
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
//            else
//            {
//                self.selectedGroup = [objects objectAtIndex:0];
//            }
//            
//        }
//    }];
//    }
//
//    
}



@end
