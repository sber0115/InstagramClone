//
//  SignUpViewController.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"
#import "Post.h"

static NSString * const USER_PROFILE_IMAGE_KEY = @"profileImageFile";
static NSString * const USER_FULLNAME_KEY = @"fullName";
static NSString * const DEFAULT_PROFILE_IMAGE_FILE = @"default-profile-picture.png";
static NSString * const SIGNED_UP_SEGUE = @"SignedUp";


@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties --> added profile image and full name support
    //default profile image is set here
    newUser.username = self.signupUsernameTextField.text;
    newUser.email = self.signupEmailTextField.text;
    newUser.password = self.signupPasswordTextField.text;
    newUser[USER_PROFILE_IMAGE_KEY] = [Post getPFFileFromImage:[UIImage imageNamed:DEFAULT_PROFILE_IMAGE_FILE]];
    newUser[USER_FULLNAME_KEY] = self.signupFullnameTextField.text;
    
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:SIGNED_UP_SEGUE sender:self];
        }
    }];
}


- (IBAction)finalSignupButton:(id)sender {
    
    [self registerUser];
    
}

- (IBAction)cancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
