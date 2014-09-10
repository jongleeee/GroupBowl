//
//  EditProfileViewController.h
//  HS
//
//  Created by Irene Lee on 7/23/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface EditProfileViewController : UIViewController <UIActionSheetDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate> {
    AppDelegate *appDelegate;
}



@property (strong, nonatomic) IBOutlet UILabel *currentUsername;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *passwordConfirmField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UIImageView *currentPicture;
@property (strong, nonatomic) UIActionSheet *actionRequired;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage *image;
@property (strong, nonatomic) IBOutlet UILabel *currentNumber;
@property (strong, nonatomic) IBOutlet UILabel *currentEmail;

@property (nonatomic, strong) PFUser *currentUser;


- (IBAction)donePressed:(id)sender;
- (IBAction)changePasswordPressed:(id)sender;
- (IBAction)imagePressed:(id)sender;
- (IBAction)logoutPressed:(id)sender;

- (void)takePhoto;
- (void)getPhoto;
- (void)uploadImage;
- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height;





@end
