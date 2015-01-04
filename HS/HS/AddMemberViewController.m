//
//  AddMemberViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "AddMemberViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

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

- (void)viewWillAppear:(BOOL)animated
{
    if (appDelegate.currentGroupName) {
        self.currentMember = [appDelegate.currentGroupName stringByAppendingString:@"_Member"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)addPressed:(id)sender {
    
    
    if ([self.memberEmail.text length] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Enter e-mail!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setDimBackground:YES];
    
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
            
            NSLog(@"1");
            
            PFQuery *queryCheck = [PFQuery queryWithClassName:self.currentMember];
            
            
            [queryCheck whereKey:@"email" equalTo:object[@"email"]];
            NSLog(@"1.2");
            
            [queryCheck getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                NSLog(@"1.7");
                if (error) {
                    [self updateGroupArray];
                } else {
                    
                    NSLog(@"%@", object[@"name"]);
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Already added!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }];
            
            
//            self.addUser = object;
//            self.tempName = self.addUser[@"name"];
//            
//            if (!self.addUser[@"group"]) {
//                NSLog(@"1.5");
//                NSArray *newgroup = [[NSArray alloc] initWithObjects:appDelegate.currentGroupName, nil];
//                self.addUser[@"group"] = newgroup;
//            } else {
//                [self.addUser[@"group"] addObject:appDelegate.currentGroupName];
//
//            }
//            NSLog(@"%@", self.addUser[@"group"]);
//            NSLog(@"1.9");
            
//            [self.addUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (error) {
//                    NSLog(@"%@", error);
//                }
//                if (!error) {
//                    
//                    NSLog(@"2");
//                    
//                    PFObject *newUser = [PFObject objectWithClassName:self.currentMember];
//                    
//                    newUser[@"name"] = self.tempName;
//                    newUser[@"title"] = @"Member";
//                    
//                    [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                        if (error)
//                        {
//                            NSLog(@"error: %@", error);
//                        } else {
//                            
//                            NSLog(@"3");
//                            
//                            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
//                            
//                            [self.navigationController popToRootViewControllerAnimated:YES];
//                            
//                        }
//                        
//                    }];
//                    
//                }
//            }];
            
            
            
        

            
        }
    }];
     
    
            
    
     
}


- (void)updateGroupArray {
    
    NSLog(@"1.3");
    
    if (!self.addUser[@"groups"]) {
        NSLog(@"1.5");
        NSMutableArray *newgroup = [[NSMutableArray alloc] initWithObjects:appDelegate.currentGroupName, nil];
        self.addUser[@"groups"] = newgroup;
    } else {
        [self.addUser[@"groups"] addObject:appDelegate.currentGroupName];
        
    }
    
    
    NSLog(@"%@", self.addUser[@"groups"]);

    NSLog(@"%@", self.addUser[@"name"]);

    NSLog(@"1.7");
    
//    NSString *tempStr = [[NSString alloc] initWithString:self.addUser[@"objectId"]];
    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    params[@"userID"] = self.addUser[@"objectId"];
//    params[@"groupList"] = self.addUser[@"groups"];
    
//    NSDictionary *params = @{
//                             @"userID" : self.addUser[@"objectId"],
//                             @"groupList" : self.addUser[@"groups"]
//                             };
//    
    
  
    
    NSLog(@"1.75");
    
//    [PFCloud callFunctionInBackground:@"hello"
//                       withParameters:@{}
//                                block:^(NSString *result, NSError *error) {
//                                    NSLog(@"1.8");
//                                    if (!error) {
//                                        // result is @"Hello world!"
//                                    }
//                                }];
    
    [PFCloud callFunctionInBackground:@"updateMember"
                       withParameters: @{@"userID" : [NSString stringWithFormat:@"%@", self.addUser[@"email"]],
                                         @"groupList" : [NSArray arrayWithArray:self.addUser[@"groups"]]}
                                block:^(NSNumber *ratings, NSError *error) {
                                    NSLog(@"%@", self.addUser[@"groups"]);
                                    NSLog(@"1.9");

                                    if (!error) {
                                        
                                        NSLog(@"2.3");

                                        PFObject *newUser = [PFObject objectWithClassName:self.currentMember];
                                        
                                        
                                        
                                        newUser[@"name"] = self.addUser[@"name"];
                                        newUser[@"phone"] = self.addUser[@"phone"];
                                        newUser[@"email"] = self.addUser[@"email"];
                                        newUser[@"title"] = @"Member";

                                        [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                            
                                            NSLog(@"3.2");
                                            
                                            if (error)
                                            {
                                                NSLog(@"error: %@", error);
                                            } else {

                                                NSLog(@"3.5");
                                                
                                                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                                                
                                                [self.navigationController popToRootViewControllerAnimated:YES];
                                                
                                            }
                                            
                                        }];
                                    }
                                    
                                }];
    
//    [PFCloud callFunctionInBackground:@"updateMember"
//                       withParameters:@{@"userID": self.addUser[@"objectId"]}
//                                block:^(NSString *result, NSError *error) {
//                                    
//                                    NSLog(@"1.9");
//                                    
//                                    if (!error) {
//                                       
//                                        PFObject *newUser = [PFObject objectWithClassName:self.currentMember];
//                            
//                                        newUser[@"name"] = self.tempName;
//                                        newUser[@"title"] = @"Member";
//                            
//                                        [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                                            if (error)
//                                            {
//                                                NSLog(@"error: %@", error);
//                                            } else {
//                                                
//                                                NSLog(@"3");
//                                                
//                                                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
//                                                
//                                                [self.navigationController popToRootViewControllerAnimated:YES];
//                                                
//                                            }
//                                            
//                                        }];
//                                        
//                                    }
//                                }];
    
//    [PFCloud callFunctionInBackground:@"updateMember" withParameters:@{@"userID": self.addUser[@"objectID"], @"groupList": self.addUser[@"groups"]} block:^(id object, NSError *error) {
//        
//        NSLog(@"1.9");
//        
//        if (!error) {
//            
//            PFObject *newUser = [PFObject objectWithClassName:self.currentMember];
//            
//            newUser[@"name"] = self.tempName;
//            newUser[@"title"] = @"Member";
//            
//            [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (error)
//                {
//                    NSLog(@"error: %@", error);
//                } else {
//                    
//                    NSLog(@"3");
//                    
//                    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
//                    
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                    
//                }
//                
//            }];
//
//        }
//    }];
//    
    



    
}

@end
