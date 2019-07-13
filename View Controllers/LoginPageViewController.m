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


static NSString * const ALERT_TITLE = @"Incorrect Credentials";
static NSString * const ALERT_MESSAGE = @"Please check inputted username/password";
static NSString * const SIGNED_IN_SEGUE = @"SignedIn";


@interface LoginPageViewController ()

@end

@implementation LoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void) incorrectCredentialsAlert
{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: ALERT_TITLE
                                                                   message:ALERT_MESSAGE
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)loginUser {
    NSString *username = self.usernameTextLabel.text;
    NSString *password = self.passwordTextLabel.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            [self incorrectCredentialsAlert];
        }
        else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
             [self performSegueWithIdentifier:SIGNED_IN_SEGUE sender:self];
        }
    }];
}


- (IBAction)signinButton:(id)sender {
    [self loginUser];
}


- (IBAction)usernameAction:(id)sender {
    [self.usernameTextLabel resignFirstResponder];
}

- (IBAction)passwordAction:(id)sender {
    [self.passwordTextLabel resignFirstResponder];
}



@end
