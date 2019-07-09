//
//  LoginPageViewController.h
//  InstagramClone
//
//  Created by sbernal0115 on 7/8/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *instaText;
- (IBAction)signinButton:(id)sender;
- (IBAction)signupButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;


@end

NS_ASSUME_NONNULL_END
