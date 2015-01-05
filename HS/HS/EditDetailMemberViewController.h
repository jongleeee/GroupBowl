//
//  EditDetailMemberViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface EditDetailMemberViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    AppDelegate *appDelegate;
}

@property (nonatomic, strong) PFUser *detailUser;
@property (strong, nonatomic) IBOutlet UIPickerView *titleList;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, readwrite) NSInteger titleComponent;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *groupName;

- (IBAction)updatePressed:(id)sender;


@property (nonatomic, strong) NSString *userEmail;


@end
