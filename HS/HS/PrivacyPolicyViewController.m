//
//  PrivacyPolicyViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/30/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "PrivacyPolicyViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>


@interface PrivacyPolicyViewController ()

@end

@implementation PrivacyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setDetailsLabelText:@"Loading..."];
    [hud setDimBackground:YES];
    
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://policy-portal.truste.com/core/privacy-policy/HeapStack/1309c940-59f3-455d-a321-16779bf3cdfd"]];
    [self.privacyPolicy loadRequest:URLRequest];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];

}





@end
