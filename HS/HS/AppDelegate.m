//
//  AppDelegate.m
//  HS
//
//  Created by Irene Lee on 7/10/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate

@synthesize currentUser;
@synthesize selectedGroup;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // Override point for customization after application launch.
    
    [Parse setApplicationId:@"nqi7esegIm4RP8lREeDJ2TAkVXFvaxZiKArce63Y"
                  clientKey:@"BFSzX2cK1IiDXKKU9ax7pHu8fIOBfUcX1GwdZy4L"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.749 green:0.176 blue:0.263 alpha:1]];
    

    
    self.currentUser = [PFUser currentUser];
    if (self.currentUser)
    {
        
        
        
        self.currentUserName = self.currentUser[@"username"];
        NSString *getList = @"_GroupList";
        NSString *groupList = [self.currentUser[@"username"] stringByAppendingString:getList];
        
        
        self.currentQuery = [PFQuery queryWithClassName:groupList];
        
        [self.currentQuery orderByDescending:@"updatedAt"];

        
        [self.currentQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {


            if (error)
            {

                
                NSLog(@"error: %@", error);
            }
            else
            {

                if ([objects count] == 1)
                {
                    self.group = NO;
                    self.selectedGroup = nil;
                }
                else
                {
                    self.group = YES;
                    self.selectedGroup = [objects objectAtIndex:0];
                }

            }
        }];
        
    }
    else
    {
        self.group = NO;
        self.selectedGroup = nil;
    }
    
    
    
    
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end