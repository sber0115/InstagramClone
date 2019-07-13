//
//  PostCell.h
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import "PFImageView.h"

@import Parse;


NS_ASSUME_NONNULL_BEGIN


@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *postCaptionLabel;
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *numLikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *postUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTimeElapsedLabel;

- (IBAction)likeButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

- (void)makePost:(Post *)post;

@end

NS_ASSUME_NONNULL_END
