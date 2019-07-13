//
//  DetailedViewViewController.h
//  InstagramClone
//
//  Created by sbernal0115 on 7/10/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import "PFImageView.h"

@import Parse;


NS_ASSUME_NONNULL_BEGIN

@interface DetailedViewViewController : UIViewController

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *postPicImageView;
@property (weak, nonatomic) IBOutlet UILabel *postCaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *postUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;


@end

NS_ASSUME_NONNULL_END
