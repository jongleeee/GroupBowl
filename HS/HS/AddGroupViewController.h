//
//  AddGroupViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface AddGroupViewController : UIViewController <UITextFieldDelegate> {
    AppDelegate *appDelegate;

}
- (IBAction)donePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *groupName;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSString *currentName;

@end
