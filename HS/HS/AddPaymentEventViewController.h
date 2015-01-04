//
//  AddPaymentEventViewController.h
//  HS
//
//  Created by Jong Yun Lee on 12/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPaymentEventViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *eventTitle;
@property (strong, nonatomic) IBOutlet UITextField *feeAmount;
@property (strong, nonatomic) IBOutlet UITextView *eventDetail;
@property (strong, nonatomic) IBOutlet UIDatePicker *eventDate;

- (IBAction)donePressed:(id)sender;




@end
