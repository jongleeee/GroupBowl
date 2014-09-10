//
//  TemplateViewController.m
//  HS
//
//  Created by Irene Lee on 8/5/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "TemplateViewController.h"
#import "MakeNewGroupViewController.h"
#import "AppDelegate.h"

@interface TemplateViewController ()

- (IBAction)newButtonPressed:(UIButton *)sender;

@end

@implementation TemplateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)newButtonPressed:(UIButton *)sender {
    // create a new view
    UIView *viewPopup=[[UIView alloc]init];
    [viewPopup setBackgroundColor:[UIColor blueColor]];
    viewPopup.alpha=0.6f;
    
    // add into window
    AppDelegate *appdelgateobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appdelgateobj.window addSubview:viewPopup];
    [appdelgateobj.window bringSubviewToFront:viewPopup];}
@end
