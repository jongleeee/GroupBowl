//
//  AddMemberViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "AddMemberViewController.h"

@interface AddMemberViewController ()

@end

@implementation AddMemberViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];

    // Do any additional setup after loading the view.
    self.memberEmail.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)addPressed:(id)sender {
    
    if (appDelegate.group == NO)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Must be in a group!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    
    if ([self.memberEmail.text length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Enter e-mail!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"email" equalTo:self.memberEmail.text];

    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Not found!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        else
        {
            self.addUser = object;
            
            NSLog(@"TRYING TO ADD: %@ to %@", self.addUser[@"email"], appDelegate.selectedGroup[@"name"]);
            

            NSString *groupName = appDelegate.currentGroupName;
            NSLog(@"here");
            PFObject *newUser = [PFObject objectWithClassName:groupName];
            NSLog(@"stop");
            newUser[@"user"] = @"user";
            newUser[@"username"] = self.addUser[@"name"];
            newUser[@"userNAME"] = self.addUser[@"username"];
            newUser[@"title"] = @"Member";
            
            NSLog(@"ADDING USER");
            
            [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error)
                {
                    NSLog(@"error: %@", error);
                }
            
            }];
            
            NSLog(@"ADDING _GROUPLIST");
            
            NSString *getList = @"_GroupList";
            NSString *addMember = [self.addUser[@"username"] stringByAppendingString:getList];
            
            
            
            PFObject *newMember = [PFObject objectWithClassName:addMember];
            
            
            
            newMember[@"name"] = appDelegate.selectedGroup[@"name"];
            
            [newMember saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error)
                {
                    NSLog(@"error: %@", error);
                }
                
            }];

            
            NSLog(@"ADDED _TTILE");
            
            [self.navigationController popToRootViewControllerAnimated:YES];

            
        }
    }];
     
    
            
            
    
            
    
            
            
            
        

        

        
        
        
        
        

    
    

     
    
     
}
@end
