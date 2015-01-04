//
//  EditProfileViewController.m
//  HS
//
//  Created by Irene Lee on 7/23/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EditProfileViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];

    self.currentUser = appDelegate.currentUser;
    self.currentPicture.userInteractionEnabled = YES;
    self.nameField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.currentEmail.text = self.currentUser[@"email"];

    

}

-(void)dismissKeyboard {
    [self.phoneField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    
    

}






- (IBAction)donePressed:(id)sender {
    
    
    NSString *parse_usernameField = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *parse_passwordField = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *parse_passwordConfirmField = [self.passwordConfirmField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
   
    NSString *parse_phoneField = [self.phoneField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if (parse_usernameField.length == 0 && parse_phoneField.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"missing information" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        return;
        
    }
    else if (parse_usernameField.length != 0 && parse_phoneField.length == 0)
    {
        self.currentUser[@"name"] = parse_usernameField;
    }
    else if (parse_usernameField.length == 0 && parse_phoneField.length != 0)
    {
        self.currentUser[@"phone"] = parse_phoneField;
    }
    else
    {
        self.currentUser[@"name"] = parse_usernameField;
        self.currentUser[@"phone"] = parse_phoneField;
        
        
    }
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@, %@", error, [error userInfo]);
        }
    }];

    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (IBAction)changePasswordPressed:(id)sender {
    
    [PFUser requestPasswordResetForEmailInBackground:self.currentUser[@"email"]];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Request Sent" message:@"please check your email" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

- (IBAction)imagePressed:(id)sender {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose from Album", nil];

    [action showInView:self.view];
    

}

- (IBAction)logoutPressed:(id)sender {
    [PFUser logOut];
    appDelegate.currentUser = nil;
    self.tabBarController.selectedIndex = 0;
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
//        [self takePhoto];
//        [self uploadImage];

    }
    else if (buttonIndex == 1)
    {
//        [self getPhoto];
//        [self uploadImage];

    }

    
}



#pragma mark - Upload Method
- (void)takePhoto
{

    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
    
    
}

- (void)getPhoto
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}




- (void)uploadImage
{
    NSData *fileData;
    NSString *fileName;
    NSString *fileType;
    
    if (self.image != nil)
    {
        UIImage *newImage = [self resizeImage:self.image toWidth:120.0f andHeight:131.0f];
    
        fileData = UIImagePNGRepresentation(newImage);
        fileName = @"image.png";
        fileType = @"image";
    }
    
    
    PFFile *file = [PFFile fileWithName:fileName data:fileData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"please try again" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else
        {
//            PFObject *profilePic = [PFObject objectWithClassName:@"UserPhoto"];
//            [profilePic setObject:file forKey:@"imageFile"];
//            [profilePic setObject:[PFUser currentUser] forKey:@"user"];
//            
//            [profilePic saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (error)
//                {
//                    NSLog(@"Error: %@", error);
//                    
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"please try again" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//                    [alertView show];
//                }
//            }];

            PFUser *currentUser = [PFUser currentUser];
            currentUser[@"userphoto"] = file;
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error)
                {
                    NSLog(@"Error: %@", error);

                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"please try again" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }];

        }
        
    }];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}


- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height
{
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRectangle = CGRectMake(0, 0, width, height);
    
    UIGraphicsBeginImageContext(newSize);
    [self.image drawInRect:newRectangle];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
    
}





@end
