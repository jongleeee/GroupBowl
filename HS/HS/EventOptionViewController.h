//
//  EventOptionViewController.h
//  HS
//
//  Created by Jong Yun Lee on 12/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventOptionViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *eventOption;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, readwrite) NSInteger optionComponent;
- (IBAction)optionSelected:(id)sender;

@end
