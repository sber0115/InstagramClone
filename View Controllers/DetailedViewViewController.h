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
@property (weak, nonatomic) IBOutlet PFImageView *postPic;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (weak, nonatomic) IBOutlet UILabel *postLikes;
@property (weak, nonatomic) IBOutlet UILabel *postUsername;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;


@end

NS_ASSUME_NONNULL_END
