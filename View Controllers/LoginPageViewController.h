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
@property (weak, nonatomic) IBOutlet UILabel *instaTextLabel;
- (IBAction)signinButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextLabel;

- (IBAction)usernameAction:(id)sender;
- (IBAction)passwordAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
