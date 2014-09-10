//
//  UpdateNewsViewController.h
//  HS
//
//  Created by Irene Lee on 7/17/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "AppDelegate.h"

@interface UpdateNewsViewController  : UIViewController <UITextFieldDelegate, UITextViewDelegate> {
    AppDelegate *appDelegate;
}

@property (strong, nonatomic) IBOutlet UITextView *textField;
@property (strong, nonatomic) IBOutlet UITextField *titleField;

- (IBAction)updatePressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;

@end
