//
//  PostCell.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"
#import "NSDate+DateTools.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (IBAction)likeButton:(id)sender {
}

- (void)makePost:(Post *)post {
    _post = post;
    
    NSDate *createdAtDate = post.createdAtDate;
    
    NSDate *timeAgoDate = [NSDate dateWithTimeInterval:0 sinceDate:createdAtDate];

    self.postTimeElapsedLabel.text = timeAgoDate.shortTimeAgoSinceNow;
    
    self.postPhotoImageView.file = post.image;
    [self.postPhotoImageView loadInBackground];
    self.postCaptionLabel.text = post.caption;
    self.numLikesLabel.text = [NSString stringWithFormat:@"%lu",post.usersWhoLikedArray.count];
    
    PFUser *author = post[@"author"];
    self.postUsernameLabel.text = author[@"username"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end
