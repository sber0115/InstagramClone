//
//  LoginPageViewController.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/8/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "LoginPageViewController.h"
#import "FeedViewController.h"
#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface LoginPageViewController ()

@end

@implementation LoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (void)loginUser {
    NSString *username = self.usernameText.text;
    NSString *password = self.passwordText.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
             [self performSegueWithIdentifier:@"SignedIn" sender:self];
        }
    }];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}




- (IBAction)signinButton:(id)sender {
    [self loginUser];
}

- (IBAction)signupButton:(id)sender {
}




@end
