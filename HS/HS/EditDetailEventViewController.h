//
//  EditDetailEventViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditDetailEventViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) PFObject *detailEvent;
@property (strong, nonatomic) IBOutlet UITextField *editTitle;
@property (strong, nonatomic) IBOutlet UITextView *editContents;
- (IBAction)updatePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *editDate;

@end
