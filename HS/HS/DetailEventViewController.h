//
//  DetailEventViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface DetailEventViewController : UIViewController {
    AppDelegate *appDelegate;
}

@property (nonatomic, strong) PFObject *detailEvent;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UITextView *contents;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
- (IBAction)editPressed:(id)sender;

@end
