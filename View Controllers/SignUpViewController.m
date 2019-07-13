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

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties --> added profile image and full name support
    //default profile image is set here
    newUser.username = self.signupUsername.text;
    newUser.email = self.signupEmail.text;
    newUser.password = self.signupPassword.text;
    newUser[@"profileImageFile"] = [Post getPFFileFromImage:[UIImage imageNamed:@"default-profile-picture.png"]];
    newUser[@"fullName"] = self.signupFullname.text;
    
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            
            [self performSegueWithIdentifier:@"SignedUp" sender:self];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)finalSignup:(id)sender {
    
    [self registerUser];
    
}


@end
