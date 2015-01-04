//
//  EventOptionViewController.m
//  HS
//
//  Created by Jong Yun Lee on 12/29/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EventOptionViewController.h"

@interface EventOptionViewController ()

@end

@implementation EventOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.options = [[NSArray alloc] initWithObjects:@"Normal", @"Payment", nil];
    self.eventOption.delegate = self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.options count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.options objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.optionComponent = row;
    
    
}



- (IBAction)optionSelected:(id)sender {
    
    if (self.optionComponent == 0) {
        [self performSegueWithIdentifier:@"normalEvent" sender:self];
    }
    else if (self.optionComponent == 1) {
        [self performSegueWithIdentifier:@"paymentEvent" sender:self];
    }
    
}
@end
