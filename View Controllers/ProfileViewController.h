//
//  ProfileViewController.h
//  InstagramClone
//
//  Created by sbernal0115 on 7/11/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "PostedPicCell.h"
#import "Post.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *profileImageImageView;
@property (weak, nonatomic) IBOutlet UILabel *numPostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end



NS_ASSUME_NONNULL_END
