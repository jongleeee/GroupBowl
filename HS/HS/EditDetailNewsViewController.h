//
//  EditDetailNewsViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/6/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditDetailNewsViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) PFObject *editNewsFeed;

@property (strong, nonatomic) IBOutlet UITextField *detailTitle;
@property (strong, nonatomic) IBOutlet UITextView *contents;
- (IBAction)updatePressed:(id)sender;

@end
