//
//  SignUpViewController.h
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *signupEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *signupFullnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *signupUsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *signupPasswordTextField;
- (IBAction)finalSignupButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

NS_ASSUME_NONNULL_END
