//
//  AddGroupViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "AddGroupViewController.h"
#import "MainTabBarViewController.h"

@interface AddGroupViewController ()

@end

@implementation AddGroupViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = [[UIApplication sharedApplication] delegate];

    self.groupName.delegate = self;
    self.currentUser = appDelegate.currentUser;
    self.currentName = self.currentUser[@"username"];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)donePressed:(id)sender {
    

   
    PFQuery *query = [PFQuery queryWithClassName:self.groupName.text];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"error: %@", error);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Name required" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([objects count] == 0)
        {

            
            PFObject *createGroup = [PFObject objectWithClassName:self.groupName.text];
            
            createGroup[@"name"] = self.groupName.text;
            
            createGroup[@"user"] = @"user";
            
            createGroup[@"username"] = self.currentName;
            
            createGroup[@"title"] = @"Leader";
            
            NSString *getList = @"_GroupList";
            NSString *groupList = [self.currentName stringByAppendingString:getList];
            
            [createGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (error)
                {
                    NSLog(@"Error: %@", error);
                    return;
                }
                else
                {
                    
                            PFObject *addGroup = [PFObject objectWithClassName:groupList];
                            addGroup[@"group"] = @"group";
                            addGroup[@"name"] = self.groupName.text;
                    
                            [addGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                if (error)
                                {

                                    NSLog(@"error: %@", error);
                                }

                            }];
                        }
                }];
            
        
    
            appDelegate.selectedGroup = createGroup;
            appDelegate.group = YES;

    
            NSString *newFeed = @"_NewsFeed";
            
            NSString *event = @"_Event";
            
            NSString *groupNewsFeed = [self.groupName.text stringByAppendingString:newFeed];
            NSString *groupEvent = [self.groupName.text stringByAppendingString:event];
            
            PFObject *createGroupNewsFeed = [PFObject objectWithClassName:groupNewsFeed];
            [createGroupNewsFeed saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error)
                {
                    NSLog(@"Error: %@", error);
                    return;
                }
            }];
            
            PFObject *createGroupEvent = [PFObject objectWithClassName:groupEvent];
            
            [createGroupEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error)
                {
                    NSLog(@"Error: %@", error);
                    return;
                }
                else
                {
                    [self.navigationController popToRootViewControllerAnimated:YES];

                }

            }];
            
            
    
            

            
        }
        else if ([objects count] != 0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Group name already exist!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [alertView show];
        }
        
        
    }];
    
    
    
}
@end
