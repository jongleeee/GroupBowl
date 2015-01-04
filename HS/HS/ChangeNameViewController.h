//
//  ChangeNameViewController.h
//  HS
//
//  Created by Jong Yun Lee on 12/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ChangeNameViewController : UIViewController {
    AppDelegate *appDelegate;
}

@property (strong, nonatomic) IBOutlet UILabel *currentName;
@property (strong, nonatomic) IBOutlet UITextField *name;

- (IBAction)updateName:(id)sender;
@end
