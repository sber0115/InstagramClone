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
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *numLikes;
@property (weak, nonatomic) IBOutlet UILabel *postUsername;
@property (weak, nonatomic) IBOutlet UILabel *postTimeElapsed;

- (IBAction)pressLike:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *pressComment;

@property (weak, nonatomic) IBOutlet UILabel *commentCount;




- (void)makePost:(Post *)post;



@end

NS_ASSUME_NONNULL_END
