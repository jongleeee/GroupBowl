//
//  DetailNewsFeedViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface DetailNewsFeedViewController : UIViewController {
    AppDelegate *appDelegate;
}


@property (nonatomic, strong) PFObject *detailObject;
@property (strong, nonatomic) IBOutlet UILabel *titleField;
@property (strong, nonatomic) IBOutlet UITextView *detailField;
- (IBAction)editPressed:(id)sender;

@end
