//
//  ChangePhoneNumberViewController.h
//  HS
//
//  Created by Jong Yun Lee on 12/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ChangePhoneNumberViewController : UIViewController {
    AppDelegate *appDelegate;
}


@property (strong, nonatomic) IBOutlet UILabel *currentPhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;

- (IBAction)updateNumber:(id)sender;

@end
