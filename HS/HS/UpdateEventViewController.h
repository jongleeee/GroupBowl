//
//  UpdateEventViewController.h
//  HS
//
//  Created by Irene Lee on 7/21/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Event.h"
#import "AppDelegate.h"

@interface UpdateEventViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UITextView *contentsField;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateAndTime;
@property (strong, nonatomic) PFObject *selectedEvent;

- (IBAction)donePressed:(id)sender;

@end
