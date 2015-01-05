//
//  AddPaymentEventViewController.h
//  HS
//
//  Created by Jong Yun Lee on 12/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AddPaymentEventViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {
    AppDelegate *appDelegate;
}


@property (strong, nonatomic) IBOutlet UITextField *eventTitle;
@property (strong, nonatomic) IBOutlet UITextField *feeAmount;
@property (strong, nonatomic) IBOutlet UITextView *eventDetail;
@property (strong, nonatomic) IBOutlet UIDatePicker *eventDate;
@property (strong, nonatomic) IBOutlet UITextField *venmoId;

- (IBAction)donePressed:(id)sender;




@end
