//
//  EditDetailMemberViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EditDetailMemberViewController.h"

@interface EditDetailMemberViewController ()

@end

@implementation EditDetailMemberViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = [[UIApplication sharedApplication] delegate];

    
    
    self.titles = [[NSArray alloc] initWithObjects:@"Member", @"Leader", nil];
    self.titleList.delegate = self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.detailUsername.text = self.userName;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.titles count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.titles objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.titleComponent = row;
    

}



- (IBAction)updatePressed:(id)sender {
    
    NSString *changeTitle = @"title";

    
    PFQuery *query = [PFQuery queryWithClassName:appDelegate.currentGroupName];
    [query whereKey:@"userNAME" equalTo:self.userID];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (error)
        {
            NSLog(@"error: %@", error);
        }
        else
        {
            if (self.titleComponent == 0)
            {
                object[@"title"] = @"Member";
            }
            else if (self.titleComponent == 1)
            {
                object[@"title"] = @"Leader";
            }
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error)
                {
                    NSLog(@"error: %@", error);
                }
                else
                {
                    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Title Updated!" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alerView show];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }
    }];
    
//    if (self.titleComponent == 0)
//    {
//        self.detailUser[changeTitle] = @"Member";
//
//    }
//    else if (self.titleComponent == 1)
//    {
//        self.detailUser[changeTitle] = @"Leader";
//    }
//    
//    [self.detailUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (error)
//        {
//            NSLog(@"error: %@", error);
//        }
//        else
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Title Updated!" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            
//            [alertView show];
//            
//
//        }
//    }];
//    [self.navigationController popToRootViewControllerAnimated:YES];

    
    
}
@end
